require 'rubygems'
require 'mysql2'
require 'active_record'
require 'json'
require 'builder'
require 'sinatra'

dbconfig = {
			:adapter  => "mysql2",
			:host     => "localhost",
			:username => "root",
			:password => "love13",
			:database => "interfolio_primary"
		}

ActiveRecord::Base.establish_connection(dbconfig)

get '/' do 
	"That's the name of the game"
end

get '/positions.?:format?' do 	
		case params[:format]
		  when 'xml'
		    Position.all().to_xml
		  when 'json'
		    Position.all().to_json
		  else
		    Position.all().to_json
		 end
end

get '/position/:id/?:format?' do  
	case params[:format]
	  when 'xml'
	    Position.find(params[:id]).to_xml
	  when 'json'
		Position.find(params[:id]).to_json
	  else
	    "Sorry your request could not be processed."
	 end
end


class Position < ActiveRecord::Base

end

=begin
class PositionAPI < ActiveRecord::Base
	class << self

		dbconfig = {
			:adapter  => "mysql2",
			:host     => "localhost",
			:username => "root",
			:password => "love13",
			:database => "interfolio_primary"
		}
		ActiveRecord::Base.establish_connection(dbconfig)

		def get_positions()
			query = 'select * from positions';
			self.connection.select_all(query)
		end

		def get_position(id)
			query = 'select * from positions where id = #{params[:id]}'
			self.connection.select_rows(query)
		end
	end
end
=end