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

	it "post en la raiz" do
		post '/'
		expect(last_response).to be_ok
	end

	
end
