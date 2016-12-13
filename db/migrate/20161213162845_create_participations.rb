class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
      t.integer :mid
      t.integer :pid
      t.integer :uid
      t.date :startdate
      t.date :enddate
      t.integer :attention

      t.timestamps null: false
    end
  end
end
