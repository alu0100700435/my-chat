source 'https://rubygems.org'
ruby "2.1.2"

gem 'thin'
gem 'sinatra'
gem 'data_mapper'
gem 'sinatra-contrib'

group :development do
  	gem 'sinatra-contrib'
 	gem "sqlite3"
	gem "dm-sqlite-adapter"
end

group :production do
	gem "pg"
	gem "dm-postgres-adapter"
end


group :test do
	gem "sqlite3"
	gem "dm-sqlite-adapter"
    gem "rack-test"
    gem "rake"
end