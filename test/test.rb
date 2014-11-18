# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
include Rack::Test::Methods

def app
	Sinatra::Application
end


describe "My Own Chat" do
	before :each do
		@browser = Selenium::WebDriver.for :firefox
		@site = 'http://my-own-chat.herokuapp.com/'
		if (ARGV[0].to_s == "local")
			@site = 'localhost:9292/'
		end
		@browser.get(@site)
		@wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds
	end
	it "Hay un log in" do
		begin
			element = @wait.until { @browser.find_element(:id,"LogIn") }
		ensure
			element = element.text.to_s
			assert_equal(true, element.include?("Log in"))
			@browser.quit
		end
	end

end