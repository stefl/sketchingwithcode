# Defines our constants
PADRINO_ENV  = ENV["PADRINO_ENV"] ||= ENV["RACK_ENV"] ||= "development"  unless defined?(PADRINO_ENV)
PADRINO_ROOT = File.expand_path('../..', __FILE__) unless defined?(PADRINO_ROOT)

# Load our dependencies
require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default, PADRINO_ENV)

Dropbox::API::Config.app_key    = ENV["DROPBOX_APP_KEY"]
Dropbox::API::Config.app_secret = ENV["DROPBOX_APP_SECRET"]
Dropbox::API::Config.mode       = "sandbox"

ENV["REDISTOGO_URL"] ||= "redis://localhost:6379/"
uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

Padrino.before_load do
end

Padrino.after_load do
end

Padrino.load!
