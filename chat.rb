require 'sinatra' 
require 'sinatra/reloader' if development?
require 'rubygems'
require 'data_mapper'
require 'erubis'
require 'pp'


configure :development do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/my_chat.db")
end
configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
end



DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true 

require_relative 'model'

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

use Rack::Session::Pool, :expire_after => 2592000
set :session_secret, '*&(^#234a)'

helpers do
	def current_user
		@current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end

get "/" do 

end

post "/" do

end

get '/send' do
end

get '/update' do

end


get '/logout' do

end


error do
end

not_found do
end