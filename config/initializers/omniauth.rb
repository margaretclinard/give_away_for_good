Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['0s2juCWWEKw2jfcKBWyaCOSHM'], ENV['U9xUklrRH98HxdOa772m6zDOYfn7apQQq7VVIeUyDLFqZo0Eb5']
end