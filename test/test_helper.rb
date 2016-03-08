ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Returns true if a test user is logged in.
  def vendor_is_logged_in?
    !session[:vendor_id].nil?
  end

  # Logs in a test user.
  def log_in_as(user, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if integration_test?
      post login_path, session: { email:       user.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:user_id] = user.id
    end
  end

  # Logs in a test user.
  def vendor_log_in_as(vendor, options = {})
    password    = options[:password]    || 'password'
    remember_me = options[:remember_me] || '1'
    if vendor_integration_test?
      post vendor_login_path, session: { email:       vendor.email,
                                  password:    password,
                                  remember_me: remember_me }
    else
      session[:vendor_id] = vendor.id
    end
  end

  private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end

    def vendor_integration_test?
      defined?(post_via_redirect)
    end
end
