class Plan < ActiveRecord::Base
  validates :start_datum, :end_datum, :presence => true
  has_many :attendances,:dependent => :destroy
  has_many :users, through: :attendances

  accepts_nested_attributes_for :attendances, reject_if: proc { |attributes| attributes['user_id'].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :users

  def calculate
    # Teilnehmerliste bilden
    tn = {}

    self.users.each do |u|
      name = u.vname + " " + u.nname.first + "."
      u.blockdaten ? blockwochen = blockwochen_finden(u.blockdaten,self.jahr) : blockwochen = []
      tn[name] = blockwochen
      Rails.logger.info "Blocked weeks for #{name}: #{blockwochen}"
    end
    
    folge = folge_berechnen(tn,self.jahr)
    return folge
  end

  private
#####
## Uebersetzung der eingegebenen Blockdaten in KWs
#####

  def blockwochen_finden(blockdaten,jahr)
    blockdaten.gsub!(/,/, "\n")
    blockdaten.gsub!(/bis/, "-")
    blockdaten.gsub!(/ */, "")
    blockwochen = []

    blockdaten.split(/[\r]?\n/).each do |zeile|
      case zeile
      when /^KW(\d\d?)$/
        # KW14
        blockwochen << /^KW(\d\d?)$/.match(zeile)[1].to_i
      when /^KW(\d\d?)\W(KW)?(\d\d?)$/
        # KW13-KW16 oder KW12/KW13
        start, kw, ende = /^KW(\d\d?)\W(KW)?(\d\d?)$/.match(zeile).captures
        blockwochen += (start.to_i..ende.to_i).to_a
      when /^ungeradeWochen$/
        blockwochen += (1..51).step(2).to_a
        # falls 53 Wochen
        blockwochen << 53 if "31.12.#{jahr}".to_date.cweek == 53
      when /^geradeWochen$/
        blockwochen += (2..52).step(2).to_a
      when /^\d\d?\.\d\d?\.(\d\d(\d\d)?)?$/
        # 31.10.14 oder 31.10. oder 31.10.2014
        # Rails.logger.warn "date-parser für : #{zeile}\n"
        da = zeile.split(".")
        da.last.prepend("20") if (da.size == 3 && da.last =~ /\d\d/)
        blockwochen << da.reverse!.join("-").to_date.cweek
      when /^\d\d?\.\d\d?\.(\d\d(\d\d)?)?-\d\d?\.\d\d?\.(\d\d(\d\d)?)?$/
        # 5.4.2014-21.4.2014 oder 5.4.14-21.4.14 oder 5.4.-21.4.
        daten = zeile.split("-")
        startd = daten[0].split(".")
        if startd.size == 3
          startd.last.prepend("20") if (startd.size == 3 && startd.last =~ /\d\d/)
        else
          startd[2] = jahr
        end
        endd = daten[1].split(".")
        if endd.size == 3
          endd.last.prepend("20") if (endd.size == 3 && endd.last =~ /\d\d/)
        else
          endd[2] = jahr
        end
        startw = startd.reverse!.join("-").to_date.cweek
        endw = endd.reverse!.join("-").to_date.cweek
        endw < startw ? endw += 52 : endw = endw
        Rails.logger.info "#{zeile} calculated as week #{startw} to week #{endw}"
        blockwochen += (startw..endw).to_a
      end
    end
    blockwochen.uniq.sort if blockwochen.size > 0
    return blockwochen
  end

#####
## Prio nach Anzahl der bish. Einsaetze und Anzahl der geblockten Termine
#####
  def prio_bilden(tn,folge,ges_einsaetze,ger_schalter)
    namen = []
    tln = {}
    einsaetze_pp = folge.each_with_object(Hash.new(0)) { |name,anzahl| anzahl[name] += 1}
    durchschnt_eins = folge.size * 1.0 / tn.size
    if ger_schalter == 0
      durchschnt_eins += 1
    end
    tn.keys.each do |person|
      if einsaetze_pp[person] <= durchschnt_eins && einsaetze_pp[person] <= ges_einsaetze / tn.size
        tln[person] = tn[person].size * 20 + einsaetze_pp[person] * 100 / durchschnt_eins
      end
    end
    tln = Hash[tln.sort_by{ |n,bw| bw }.reverse]
    tln.keys.each do |n|
      namen << n
    end
    return namen
  end

#####
## Berechnung der Folge unter Beruecksichtigg. der geblockten Termine
#####
  def folge_berechnen(tn,jahr)
    folge = [ "" ]
    ges_einsaetze = "28.12.#{jahr}".to_date.cweek
    ger_schalter = 1
    namen = prio_bilden(tn,folge,ges_einsaetze,ger_schalter)
    zaehler = 0
    while folge.size <= ges_einsaetze
      namen.each do |name|
        unless tn[name].find_index(folge.size) || folge.size > ges_einsaetze
          folge << name
          zaehler += 1
        end
      end
      if zaehler == 0
        if namen.size < tn.size && ger_schalter == 1
          ger_schalter = 0
        else
          folge << "nicht besetzt!"
          ger_schalter = 1
        end
      end
      zaehler = 0
      namen = prio_bilden(tn,folge,ges_einsaetze,ger_schalter)
    end
    return folge 
  end

end
