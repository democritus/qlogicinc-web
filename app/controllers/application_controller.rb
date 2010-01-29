# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :layout # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :set_locale


  private
  
  # Get locale code from request subdomain (like http://es.domain.tld)
  def extract_locale_from_subdomain
    unless request.subdomains.empty?
      parsed_locale = request.subdomains.first
    else # Assume no tld if no subdomains (assume something like "es.localhost")
      parsed_locale = request.domain.split('.')[0]
    end
    if parsed_locale
      (I18n.available_locales.include? parsed_locale.intern) ? parsed_locale.intern : nil
    end
  end
 
  def set_locale
    I18n.locale = extract_locale_from_subdomain
  end
end
