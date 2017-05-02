Rails.application.configure do
  # Code is not reloaded between requests.
config.cache_classes = true

# Eager load code on boot. This eager loads most of Rails and
# your application in memory, allowing both thread web servers
# and those relying on copy on write to perform better.
# Rake tasks automatically ignore this option for performance.
config.eager_load = true

# Full error reports are disabled and caching is turned on.
config.consider_all_requests_local       = false
config.action_controller.perform_caching = true

# Enable Rack::Cache to put a simple HTTP cache in front of your application
# Add `rack-cache` to your Gemfile before enabling this.
# For large-scale production use, consider using a caching reverse proxy like nginx,  varnish or squid.
# config.action_dispatch.rack_cache = true
 config.log_level = :info
# Disable Rails's static asset server (Apache or nginx will already do this).
config.serve_static_files = true
config.assets.compile = false

config.assets.precompile =  ['*.js', '*.css', '*.css.erb', '*.css.scss'] 
# Compress JavaScripts and CSS.
config.assets.js_compressor = :uglifier
# config.assets.css_compressor = :sass
config.assets.paths << "#{Rails.root}/assets/fonts"
config.assets.paths << "#{Rails.root}/assets/images"
config.assets.precompile += %w( .svg .eot .woff .ttf )
config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
# Do not fallback to assets pipeline if a precompiled asset is missed.
config.assets.compile = false
config.assets.precompile << /(^[^_\/]|\/[^_])[^\/]*$/
# Generate digests for assets URLs.
config.assets.digest = true

# Version of your assets, change this if you want to expire all your assets.
config.assets.version = '1.0'
end
