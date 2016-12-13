json.array!(@projekts) do |projekt|
  json.extract! projekt, :id, :title, :description, :jpissue, :startdate, :enddate
  json.url projekt_url(projekt, format: :json)
end
