json.array!(@plans) do |plan|
  json.extract! plan, :id, :termine, :t_pro_einsatz, :teilnehmer, :folge
  json.url plan_url(plan, format: :json)
end
