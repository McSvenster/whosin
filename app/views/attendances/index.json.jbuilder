json.array!(@attendances) do |attendance|
  json.extract! attendance, :id, :user_id, :plan_id
  json.url attendance_url(attendance, format: :json)
end
