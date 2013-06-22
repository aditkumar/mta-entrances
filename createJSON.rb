require 'csv'

output = 
"{ \"type\": \"FeatureCollection\",
  \"features\": ["

c = CSV.table('stationentrances.csv') 

for i in 0..c.size-1
	station = "{ \"type\": \"Feature\",
      \"geometry\": {\"type\": \"Point\", \"coordinates\": [#{c[i][28]}, #{c[i][29]}]},
      \"properties\": {\"Name\": \"#{c[i][2]}\"}
      },\n\t\t"
    output << station
end
ind = c.size-1

station = "{ \"type\": \"Feature\",
      \"geometry\": {\"type\": \"Point\", \"coordinates\": [#{c[ind][28]}, #{c[ind][29]}]},
      \"properties\": {\"Name\": \"#{c[ind][2]}\"}
      }"



output << 	"\n\t]
}"


File.open('./mta-entrances.geojson','w') {|f| f.write(output)}