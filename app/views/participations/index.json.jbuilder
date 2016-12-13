json.array!(@participations) do |participation|
  json.extract! participation, :id, :mid, :pid, :uid, :startdate, :enddate, :attention
  json.url participation_url(participation, format: :json)
end
