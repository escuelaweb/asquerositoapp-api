require 'rubygems'
require 'bundler'
require 'sinatra/base'
require 'json'
require 'mongoid'

Mongoid.load!("config/mongoid.yml")

# Load every app file, controllers and models
%w(libs/*.rb models/*.rb).each do |dir|
  Dir.glob(dir).each do |file|
    require_relative file
  end
end

class App < Sinatra::Base

  configure do
    enable :sessions
    set :port, 3000
    set :session_secret, 'asdfa2342923422f1adc05c837fa234230e3594b93824b00e930ab0fb94b'
    set :root, File.dirname(__FILE__)
    set :protection, :except => [:remote_token, :frame_options, :http_origin]
    enable :logging, :dump_errors, :raise_errors
  end
  
  before do
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS, DELETE, PUT'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-Requested-With, X-Prototype-Version, X-CSRF-Token, Origin, Accept'
  end

  run! if app_file == $0
end
