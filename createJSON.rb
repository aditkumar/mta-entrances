require 'csv'

def colors(line) 
	output = "#FFFFFF"
	lineColor = {"8 Avenue" => "#2850AD",
				"Broadway-7th Ave" => "#EE352E",
				"Lexington" => "#00933C",
				"Queens Boulevard" => "#FF6319",
				"6 Avenue" => "#FF6319",
				"Broadway" => "#FCCC0A",
				"Flushing" => "#B933AD",
				"Fulton" => "#2850AD",
				"Canarsie" => "#A7A9AC",
				"White Plains Road" => "#EE352E",
				"Broadway Jamaica" => "#996633",
				"Pelham" => "#00933C",
				"Concourse" => "#2850AD",
				"4 Avenue" => "#FCCC0A",
				"Crosstown" => "#6CBE45",
				"Jerome" => "#00933C",
				"Brighton" => "#2850AD",
				"West End" => "#FF6319",
				"Rockaway" => "#2850AD",
				"Eastern Parkway" => "#EE352E",
				"Culver" => "#FF6319",
				"Nostrand" => "#EE352E",
				"Nassau" => "#996633",
				"Liberty" => "#2850AD",
				"Astoria" => "#FCCC0A",
				"Lenox" => "#EE352E",
				"Archer Av" => "#FF6319",
				"Clark" => "#EE352E",
				"New Lots" => "#EE352E",
				"Sea Beach" => "#FCCC0A",
				"63rd Street" => "#FF6319",
				"Myrtle" => "#A7A9AC",
				"42nd St Shuttle" => "#6CBE45",
				"Dyre Av" => "#00933C",
				"Franklin" => "#FF6319",
				"Coney Island" => "#FF6319"}
	return lineColor[line] || output


	# if ["A","C","E"].include? line 
	# 	output = "#2850AD"
	# elsif ["B","D","F","M"].include? line
	# 	output = "#FF6319"
	# elsif "G" == line
	# 	output = "#6CBE45"
	# elsif ["J","Z"].include? line
	# 	output = "#996633"
	# elsif "L" == line
	# 	output = "#A7A9AC"
	# elsif ["N","Q","R"].include? line
	# 	output = "#FCCC0A"
	# elsif "S" == line
	# 	output = "#808183"
	# elsif [1,2,3].include? line
	# 	output = "#EE352E"
	# elsif [4,5,6].include? line
	# 	output = "#00933C"
	# elsif 7 == line
	# 	output = "#B933AD"
	# else
	# end
	# return output
end

def createStation(entrance,last=false)
	stationColor = colors(entrance[1])
	station = "{ \"type\": \"Feature\",
      \"geometry\": {\"type\": \"Point\", \"coordinates\": [#{entrance[4]},#{entrance[3]}]},
      \"properties\": {\"Name\": \"#{entrance[2]} (#{entrance[1]})\" , \"marker-size\" : \"small\", \"marker-color\" : \"#{stationColor}\",\"marker-symbol\" : \"circle\"}
      }"
      if !last 
      	station << ",\n\t\t"
      else 
      	station << "\n\t\t"
      end
      return station
end

def createEntrance(entrance,last=false)
	ent = "{ \"type\": \"Feature\",
      \"geometry\": {\"type\": \"LineString\", \"coordinates\": [[#{entrance[4]},#{entrance[3]}],[#{entrance[29]}, #{entrance[28]}]]},
      \"properties\": {\"Name\": \"#{entranceName(entrance)}\"}
      }"
      if !last 
      	ent << ",\n\t\t"
      else 
      	ent << "\n\t\t"
      end
      return ent
end

def entranceName(entrance)
	return "" + entrance[25].to_s + " & " + entrance[26].to_s + " " + entrance[27].to_s
end
def stationName(entrance)
	return entrance[2]+" "+entrance[1]
end

output = 
"{ \"type\": \"FeatureCollection\",
  \"features\": ["

c = CSV.table('stationentrances.csv') 

allStations = []
for i in 0..c.size-1
    output << createEntrance(c[i])
    stationHash = c[i][2].to_s + c[i][1].to_s
    if !allStations.include? stationHash
    	output << createStation(c[i])
    	allStations.push(stationHash)
    end
end
output << createEntrance(c[c.size-1],true)
output << "\n\t]
}"


File.open('./mta-entrances.geojson','w') {|f| f.write(output)}