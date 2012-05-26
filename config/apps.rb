Padrino.configure_apps do
  set :session_secret, '383e0c1c97b6a95dab734f93b738b3ec48b4d15d80983e2fc5aedd1975f1d39e'
end

Padrino.mount("Sketching").to('/')
