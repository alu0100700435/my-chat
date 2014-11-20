# -*- coding: utf-8 -*-
require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
require 'rspec'

include Rack::Test::Methods

def app
	Sinatra::Application
end

describe " My own chat - funcionalidades de las rutas" do
	it "/update" do
		get '/update'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "/send" do
		get '/send'
		expect(last_response.body).to eq("Not an ajax request")
	end

	it "get /" do
		get '/'
		expect(last_response).to be_ok
	end



	it "get /users" do
		get '/users'
		expect(last_response.body).to eq("Not an ajax request")
	end


	it "post en la raiz" do
		puts "post /raiz"
		post '/'
		expect(last_response).to be_ok
	end

	it "post /registro" do
		puts "post /reg"
		post '/registro'
		expect(last_response).to be_ok
	end

	it "post de registro" do
		puts "post /reg"
		post '/registro' , :user_reg => "raquel", :pass_reg => "123", :pass2_reg => "123"
		last_response.body['Welcome...']
	end



	it "post de registro erroneo - malas claves" do
		puts "post /reg"
		post '/registro' , :user_reg => "raquel", :pass_reg => "123", :pass2_reg => "1234"
		last_response.body['El  usuario ya existe o contraseñas no coincidentes']
	end

	it "post de registro erroneo - usuario existente" do
		puts "post /reg"
		post '/registro' , :user_reg => "raquel", :pass_reg => "12344", :pass2_reg => "12344"
		last_response.body['El  usuario ya existe o contraseñas no coincidentes']
	end

	it "post / con usuario" do
		puts "post /"
		post '/' , :user_log => "raquel", :pass_log => "123"
		last_response.body['Welcome...']
	end

	it "get / con current user" do
		post '/' , :user_log => "raquel", :pass_log => "123"
		get '/'
		last_response.body['Welcome...']
	end

	it "post / con usuario y mala contraseña" do
		puts "post /"
		post '/' , :user_log => "raquel", :pass_log => "123sgadgagag"
		last_response.body['Usuario o contraseña erronea']
	end


	it "get /logout" do
		puts "get /logout"
		post '/' , :user_log => "raquel", :pass_log => "123"
		get '/logout', :name => "raquel"
		last_response.body['Log In']
	end

	it "/send con http request" do
		post '/' , :user_log => "raquel", :pass_log => "123"
		get '/send', {}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
		last_response.body['Welcome...']
	end

	it "/update con http request" do
		post '/' , :user_log => "raquel", :pass_log => "123"
		get '/update', {}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest", :text => "hello, world"}
		expect(last_response).to be_ok
	end

	it "/update sin http request" do
		get '/update', {}, :text => "hello, world"
		expect(last_response.body).to eq("Not an ajax request")
	end
	
	it "/send sin http request" do
		get '/update', {}, :text => "hello, world"
		expect(last_response.body).to eq("Not an ajax request")
	end
end
