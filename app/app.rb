class Sketching < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Cache  
  
  enable :caching
  set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new(ENV["MEMCACHE_SERVERS"] || '127.0.0.1:11211', :exception_retry_limit => 1))

  disable :sessions
  disable :flash

  configure do
    HireFire::Initializer.initialize!
  end
  
  before do
    headers 'Cache-Control' => 'public, max-age=300' 
  end
end
