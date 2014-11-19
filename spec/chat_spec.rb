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


describe "My Own Chat" do
	before :each do
		@browser = Selenium::WebDriver.for :firefox
		@site = 'https://my-own-chat.herokuapp.com/'
		if (ARGV[0].to_s == "local")
			@site = 'localhost:9292/'
		end
		@browser.get(@site)
	end
	it "Hay un log in" do
		@browser.manage.timeouts.implicit_wait = 5
		expect(@browser.find_element(:id,"LogIn").text).to eq("Log in")
		@browser.quit
	end

end
