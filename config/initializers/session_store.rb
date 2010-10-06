# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_football_tracker_session',
  :secret      => '42edb79247d944013108697b27db3e1e749f474baebd7f90998d682f4e6ae265a13713e46fc6735f741020134c633e04d72c3c71563da09bccc5543ea0fdcd57'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
