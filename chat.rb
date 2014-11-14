require 'sinatra' 
require 'sinatra/reloader' if development?
require 'rubygems'
require 'data_mapper'
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

<<<<<<< HEAD
get "/" do 
	if current_user
		erb :index
	end
	erb :login
=======
get "/" do
	@web = "login"
	erb :login 

>>>>>>> sergio
end

post "/" do
	name_reg = params[:user_reg]
	name_log= params[:user_log]

	if name_reg 
		consult = User.first(:name => name)

		if(consult)
			@existe_user = true
		else
	 		
		end
	if name_log
		consult = User.first(:name=>name_log)

		if (consult)
			User.update(:name=>name_log, :active => true)
			session[:user_id] = consult.id
		else
			@no_existe = true
		end

	end

end

get '/send' do
end

get '/update' do

end


get '/logout' do
	User.update(:name => current_user.user, :active => false)
	session.clear

end


error do
	erb :index
end

not_found do
	erb :index
end