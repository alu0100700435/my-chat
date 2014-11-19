# -*- coding: utf-8 -*-
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'rubygems'
require 'coveralls'
Coveralls.wear!

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

	it "El usuario se puede registrar" do
		@browser.get(@site)
		@browser.manage.timeouts.implicit_wait = 5

		element = @browser.find_element(:id,"username")
		element.send_keys("user1")
		element = @browser.find_element(:id,"pass1")
		element.send_keys("123456")
		element = @browser.find_element(:id,"pass2")
		element.send_keys("123456")
		element.submit

		assert_equal(true, element.include?("welcome..."))
		@browser.quit
		
	end

	it "Las contraseñas deben ser iguales" do
		@browser.get(@site)
		@browser.manage.timeouts.implicit_wait = 5

		element = @browser.find_element(:id,"username")
		element.send_keys("user1")
		element = @browser.find_element(:id,"pass1")
		element.send_keys("12345")
		element = @browser.find_element(:id,"pass2")
		element.send_keys("123456")

		assert_equal(true, element.include?("Las contraseñas deben ser iguales"))
		@browser.quit
	end

	


end
