ENV['RACK_ENV'] = 'test' 

require File.join(File.dirname(__FILE__), '..', 'app.rb') 
require 'sinatra' 
require 'rack/test'
require 'mongoid'
require 'database_cleaner'
require 'mongoid-rspec'

# setup test environment
class App
  set :environment, :test 
  set :run, false 
  set :raise_errors, true 
  set :logging, false 
end

def app
  Sinatra::Application 
end 

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include Mongoid::Matchers
end