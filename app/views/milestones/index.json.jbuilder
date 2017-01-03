json.array!(@milestones) do |milestone|
  json.extract! milestone, :id, :pid, :title, :description, :startdate, :enddate
  json.url milestone_url(milestone, format: :json)
end
