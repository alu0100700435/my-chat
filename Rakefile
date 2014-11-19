task :default => :spec

desc "Run test"
task :test do
	sh "ruby test/test.rb"
end

desc "Run server"
    task :server do
      sh "rackup"
end

desc "run spec"
task :spec do
sh "bundle exec rspec spec"
end


