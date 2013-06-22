require 'csv'

output = 
"{ \"type\": \"FeatureCollection\",
  \"features\": [
    { \"type\": \"Feature\",
      \"geometry\": {\"type\": \"Point\", \"coordinates\": [102.0, 0.5]},
      \"properties\": {\"prop0\": \"value0\"}
	}
	]
}"

CSV.foreach('stationentrances.csv', :headers => true) do |entrance| 
	puts entrance[0]
end

File.open('./mta-entrances.geojson','w') {|f| f.write(output)}