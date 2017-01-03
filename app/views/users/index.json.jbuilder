json.array!(@users) do |user|
  json.extract! user, :id, :vname, :nname, :email, :blockdaten, :password_digest, :admin, :geloescht
  json.url user_url(user, format: :json)
end
