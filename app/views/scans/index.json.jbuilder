json.array!(@scans) do |scan|
  json.extract! scan, :id, :username, :score
  json.url scan_url(scan, format: :json)
end
