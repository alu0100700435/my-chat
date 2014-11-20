require 'sinatra' 
require 'sinatra/reloader' if development?
require 'rubygems'
require 'data_mapper'
require 'pp'


configure :development, :test do
	DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/my_chat.db")
	DataMapper::Logger.new($stdout, :debug)
	DataMapper::Model.raise_on_save_failure = true 

	require_relative 'model'

	DataMapper.finalize

	DataMapper.auto_migrate!
	#DataMapper.auto_upgrade!
end
configure :production do
	DataMapper.setup(:default, ENV['DATABASE_URL'])
	DataMapper::Logger.new($stdout, :debug)
	DataMapper::Model.raise_on_save_failure = true 

	require_relative 'model'

	DataMapper.finalize

	#DataMapper.auto_migrate!
	DataMapper.auto_upgrade!
end





use Rack::Session::Pool, :expire_after => 2592000
set :session_secret, '*&(^#234a)'

chat = ['<p id="saludo"> Welcome... </p>']


helpers do
	def current_user
		current_user ||= User.get(session[:user_id]) if session[:user_id]
	end
end

get "/" do 
	@no_existe = false;
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
	name_log= params[:user_log]
	@no_existe = false;
	@existe_user = false;
	
	if name_log

		pass = params[:pass_log].to_i(32)
		consult = User.first(:name=>name_log, :pass => pass)

		if (consult)
			consult.update(:active => true)
			consult.save
			session[:user_id] = consult.id
			session[:user] = consult.name

			redirect '/'
		else
			puts "error!!!! contraseña o usuario erroneo"
			@no_existe = true

			@web = "login"
			erb :login
		end

	end

end

post "/registro" do

	puts 'inside post'
	name_reg = params[:user_reg]
	pass = params[:pass_reg]
	pass2 = params[:pass2_reg]
	@no_existe = false;
	@existe_user = false;

	if name_reg && (pass == pass2)

		consult = User.first(:name => name_reg)

		if(consult)
			puts "error!!! existe user"
			@existe_user = true

			@web = "login"
			erb :login

		else
			pass = pass.to_i(32)
			crear = User.create(:name => name_reg, :pass => pass )
			if crear
				puts "ok"
				crear.update(:active => true)
				crear.save
				session[:user_id] = crear.id
				session[:user] = crear.name

				redirect '/'

			else
				puts "error al crear user"

				@web = "login"
				erb :login
			end
	 		
		end
	else
		
		puts "error!!! existe user"
		@existe_user = true

		@web = "login"
		erb :login
	end

end

get '/logout' do
	consult = User.first(:name=>current_user.name)
	consult.update(:active => false)
	consult.save
	session.clear
	redirect '/'

end


get '/send' do
	return [404, {}, "Not an ajax request"] unless request.xhr?
	if params['text'] != ""
   		chat << "<strong id ='#{current_user.name}'>#{current_user.name} </strong>  : #{params['text']}"
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
	    	<p class="user_n"><%= phrase.name %></p>
	    <%end%>
	  <% end %>
	HTML

end


