# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  
  # 2010-01-27 - Brian Warren - subdomain support. Subdomain indicates language
  # i.e. en.qlogicinc.com = English, es.qlogicinc.com
  
  config.gem 'mongrel'
  
  config.gem 'mysql'
  
  config.gem 'ruby-debug'
  
  config.gem 'subdomain-fu',
    :lib     => 'subdomain-fu',
    :source  => 'http://gems.github.com',
    :version => '0.5.4'

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer
  config.active_record.observers = :inquiry_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
  
  # 2009-06-01 Brian Warren
  # NOTE: Web server must be configured if non-default directory used here.
  # Default works without configuring web server:
  #   myapp/public
  # Consolidate caches in "cache" directory. Doesn't work unless web directory
  # is reconfigured:
  #   myapp/public/cache
  config.action_controller.page_cache_directory = File.join(
    Rails.root, 'public/cache'
  )
end

## SubdomainFu plugin configuration
SubdomainFu.tld_sizes = { :development => 2, :test => 1, :production => 1 }
SubdomainFu.mirrors = [ 'en', 'es', 'fr' ]
SubdomainFu.preferred_mirror = 'en'

# Constants
COMPANY_NAME = 'Qlogic Inc.'
DOMAIN = 'qlogicinc.com'
if RAILS_ENV == 'production'
  INQUIRY_EMAIL = 'info@' + DOMAIN
else
  INQUIRY_EMAIL = 'bwarren@' + DOMAIN
end

ARINC_URL = 'http://www.arinc.com/'
SITA_URL = 'http://www.sita.aero/'
RESA_URL = 'http://www.resa.aero/'

# Counts for content items
# Todo: dynamically figure out how many facts and quotes exist
FACT_COUNT = 6
QUOTE_COUNT = 6
