require 'rubygems'
require 'mysql2'
require 'json'
require 'builder'
require 'sinatra'

@@mysqlclient = Mysql2::Client.new(:host => "localhost",:username => "root",:password => "love13" ,:database => "interfolio_primary")

#test 
get '/' do 
	"Just a test route to make sure things are working!"
end

#return all positions in JSON
get '/positions.json' do
  res = Array.new
  result = @@mysqlclient.query("SELECT * FROM interfolio_primary.positions")
  result.each do |row|
  	res.push(row)
  end
  return res.to_json
end

#return all positions in XML
get '/positions.xml' do  
  result = @@mysqlclient.query("SELECT * FROM interfolio_primary.positions")
  #use builder to generate xml response
  builder do |xml|
  	xml.instruct!
       xml.positions do
	  		result.each do |row|		    
			    xml.position do
			      xml.name  "#{row['name']}"
			      xml.dateCreated "#{row['dateCreated']}"
			    end
			end
		end
   end
end

#retrieve a position by it's unique ID
get '/position/:id' do  
  #create array to hold results
  res = Array.new
  #query the database by id
  result = @@mysqlclient.query("SELECT * FROM interfolio_primary.positions WHERE id = #{params[:id]}")
    
  #loop over result set
  result.each do |row|
	  	#push the results to the array
	  	res.push(row)
  end
  
  #if the array has elements then let's display the results
  if res.length = 0
   #no data found! Let the end user know!
   res.push("No position record found")
  end 

   #return the results in json format
   return res.to_json
end