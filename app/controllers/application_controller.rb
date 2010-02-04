# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :layout # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  before_filter :set_locale, :set_page_caching_status


  private
  
  # Need variable in view to know if caching is enabled. Used to save
  # javascript into cached page so that certain dynamic things are handled by
  # client-side javascript since Rails is skipped when page caching is on
  # TODO: better way?
  def set_page_caching_status
    if perform_caching && caching_allowed
      @page_caching_active = true
    else
      @page_caching_active = false
    end
  end
  
  # Get locale code from request subdomain (like http://es.domain.tld)
  def extract_locale_from_subdomain
    unless request.subdomains.empty?
      parsed_locale = request.subdomains.first
    else # Assume no tld if no subdomains (assume something like "es.localhost")
      parsed_locale = request.domain.split('.')[0]
    end
    if parsed_locale
      # REMOVED: don't like this syntax
      #(I18n.available_locales.include? parsed_locale.intern) ? parsed_locale.intern : nil
      if I18n.available_locales.include?(parsed_locale.intern)
        parsed_locale.intern
      else
        nil
      end
    end
  end
 
  def set_locale
    I18n.locale = extract_locale_from_subdomain
  end
  
  ##
  # "cache_page" alias method which effectivly forces the domain name to be
  # pre-pended to the page cache path. Note that the "caches_page" method
  # called on actions within a controller is affected by this as well
  def cache_page_with_domain(content = nil, options = nil)
    return unless perform_caching && caching_allowed
    
    path = "/#{request.host}"
    path << case options
      when Hash
        url_for(options.merge(:only_path => true,
          :skip_relative_url_root => true, :format => params[:format]))
      when String
        options
      else
        if request.path.empty? || request.path == '/'
          '/index'
        else
          request.path
        end
    end

    cache_page_without_domain(content, path)
  end
  alias_method_chain :cache_page, :domain
end
