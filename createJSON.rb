require 'csv'

def colors(line) 
	output = "#{}FFFFFF"
	if ["A","C","E"].include? line 
		output = "#2850AD"
	elsif ["B","D","F","M"].include? line
		output = "#FF6319"
	elsif "G" == line
		output = "#6CBE45"
	elsif ["J","Z"].include? line
		output = "#996633"
	else

	end
end

def createStation
end

def createEntrance(entrance,last=false)
	station = "{ \"type\": \"Feature\",
      \"geometry\": {\"type\": \"LineString\", \"coordinates\": [[#{entrance[4]},#{entrance[3]}],[#{entrance[29]}, #{entrance[28]}]]},
      \"properties\": {\"Name\": \"#{entrance[2]}\" , \"marker-size\" : \"small\" , \"color\" : \"#B3B3B3\"}
      }"
      if !last 
      	station << ",\n\t\t"
      else 
      	station << "\n\t\t"
      end
end

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
    output << createEntrance(c[i])
end
output << createEntrance(c[c.size-1],true)
output << "\n\t]
}"


File.open('./mta-entrances-lines.geojson','w') {|f| f.write(output)}