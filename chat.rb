require 'sinatra' 
require 'sinatra/reloader' if development?
require 'rubygems'
require 'data_mapper'
require 'pp'


configure :development, :test do
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

chat = ['welcome..']


helpers do
	def current_user
		current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end

get "/" do 
	if current_user
		@web = "index"
		puts "inside current user"
		erb :index
	else

		puts "inside login"
		@web = "login"
		erb :login
	end
end

post "/" do

	puts 'inside post'
	name_reg = params[:user_reg]
	name_log= params[:user_log]

	if name_reg 
		consult = User.first(:name => name_reg)

		if(consult)
			puts "error!!! existe user"
			@existe_user = true

		else

			crear = User.create(:name => name_reg)
			if crear
				puts "ok"
			else
				puts "error al crear user"
			end
	 		
		end
	end
	if name_log
		consult = User.first(:name=>name_log)

		if (consult)
			consult.update(:active => true)
			consult.save
			session[:user_id] = consult.id
			session[:user] = consult.name
		else
			puts "error!!!! no existe user"
			@no_existe = true
		end

	end

	redirect '/'

end

get '/logout' do
	consult = User.first(:name=>current_user.name)
	consult.update(:active => false)
	consult.save
	session.clear

end


get '/send' do
	return [404, {}, "Not an ajax request"] unless request.xhr?
	if params['text'] != ""
   		chat << "#{current_user.name} : #{params['text']}"
  	end
	nil
end

get '/update' do

	return [404, {}, "Not an ajax request"] unless request.xhr?
	@updates = chat[params['last'].to_i..-1] || []

	@last = chat.size
	erb <<-'HTML', :layout => false
	  <% @updates.each do |phrase| %>
	    <%if phrase != "" %> 
	    	<%= phrase %> <br/>
	    <%end%>
	  <% end %>
	  <span data-last="<%= @last %>"></span>
	HTML

end


get '/users' do

	return [404, {}, "Not an ajax request"] unless request.xhr?
	@updates = User.all(:active => true)

	erb <<-'HTML', :layout => false
	  <% @updates.each do |phrase| %>
	    <%if phrase != "" %> 
	    	<%= phrase.name %> <br/>
	    <%end%>
	  <% end %>
	HTML

end


