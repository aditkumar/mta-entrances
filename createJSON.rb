require 'csv'

output = 
"{ \"type\": \"FeatureCollection\",
  \"features\": ["

c = CSV.table('stationentrances.csv') 

# for i in 0..c.size-1
# 	station = "{ \"type\": \"Feature\",
#       \"geometry\": {\"type\": \"Point\", \"coordinates\": [#{c[i][29]}, #{c[i][28]}]},
#       \"properties\": {\"Name\": \"#{c[i][2]}\" , \"marker-size\" : \"small\"}
#       },\n\t\t"
#     output << station
# end
# ind = c.size-1

# station = "{ \"type\": \"Feature\",
#       \"geometry\": {\"type\": \"Point\", \"coordinates\": [#{c[ind][29]}, #{c[ind][28]}]},
#       \"properties\": {\"Name\": \"#{c[ind][2]}\" , \"marker-size\" : \"small\"}
#       }"

for i in 0..c.size-1
	station = "{ \"type\": \"Feature\",
      \"geometry\": {\"type\": \"LineString\", \"coordinates\": [[#{c[i][4]},#{c[i][3]}],[#{c[i][29]}, #{c[i][28]}]]},
      \"properties\": {\"Name\": \"#{c[i][2]}\" , \"marker-size\" : \"small\"}
      },\n\t\t"
    output << station
end
ind = c.size-1

station = "{ \"type\": \"Feature\",
      \"geometry\": {\"type\": \"LineString\", \"coordinates\": [[#{c[ind][4]},#{c[ind][3]}],[#{c[ind][29]}, #{c[ind][28]}]]},
      \"properties\": {\"Name\": \"#{c[ind][2]}\" , \"marker-size\" : \"small\"}
      }"



output << station 
output << "\n\t]
}"


File.open('./mta-entrances-lines.geojson','w') {|f| f.write(output)}