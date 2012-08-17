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

# hopefully a temporary patch so HireFire will run on the Heroku Cedar stack
# NB: the worker type is hard-coded as "worker" below, this must correlate to the type in Procfile
# NB: ENV['APP_NAME'] must be defined (e.g. 'heroku config:add APP_NAME=myherokuappname')

# using ps & ps_scale instead of info & set_workers
class HireFire::Environment::Heroku
  
  private

  def workers(amount = nil)
    
    if amount.nil?
      # return client.info(ENV['APP_NAME'])[:workers].to_i
      return client.ps(ENV['APP_NAME']).select {|p| p['process'] =~ /worker.[0-9]+/}.length
    end

    # client.set_workers(ENV['APP_NAME'], amount)
    return client.ps_scale(ENV['APP_NAME'], {"type" => "worker", "qty" => amount})

  rescue RestClient::Exception
    HireFire::Logger.message("Worker query request failed with #{ $!.class.name } #{ $!.message }")
    nil
  end
end

# quick override to ensure that HireFire is activated on Heroku. The change is that it is looking for
# ::Rails.env.production? instead of ENV.include?('HEROKU_UPID')
module HireFire
  module Environment

    module ClassMethods
      
      def environment
        @environment ||= HireFire::Environment.const_get(
          if environment = HireFire.configuration.environment
            environment.to_s.camelize
          else
            ::Padrino.env == :production ? 'Heroku' : 'Noop'
          end
        ).new
      end
      
    end
  end
end

Padrino.before_load do
  Resque.workers.each do |w| w.unregister_worker end
end

Padrino.after_load do
end

Padrino.load!
