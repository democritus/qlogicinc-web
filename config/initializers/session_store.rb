# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_qlogicinc.com_session',
  :secret      => 'c353cd2ec5287d681011c39c9609386e24485a9e5c41c94810636cd7ad187bba72155d51d10442ee1546014fbcce231240762a54ea8702ffd43788aa40f3e2c5'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
