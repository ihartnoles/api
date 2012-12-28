require 'rubygems'
require 'data_mapper'
require 'json'
require 'builder'
require 'sinatra'


#DataMapper.setup(:default, "sqlite://root:love13@localhost/interfolio_primary")
DataMapper.setup(:default, "mysql://root:love13@localhost/int_primary")

=begin
DataMapper.setup(:default, 
  :adapter  => 'mysql', 
  :user     => 'root', 
  :password => 'love13', 
  :database => 'interfolio_primary'  
  )
=end

class Position
    include DataMapper::Resource
    property :id       		, Serial
    property :name 			, String
    property :dateCreated   , DateTime
end

DataMapper.finalize
Position.auto_upgrade!

#test 
get '/' do 
	"Calling ALL FREAKS!"
end

#display a page of all positions
get '/positions' do 
	@positions = Position.all(:order => [:id.desc])
	erb	:positionlist
end