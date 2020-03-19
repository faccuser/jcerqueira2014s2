json.array!(@trips) do |trip|
  json.extract! trip, :id, :title, :starts_at, :ends_at
  json.url trip_url(trip, format: :json)
end
