ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "simplecov"
SimpleCov.start
require "rails/test_help"
require "minitest/rails"
require "minitest/reporters"  # for Colorized output


#  For colorful output!
Minitest::Reporters.use!(
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter
)


# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup
    OmniAuth.config.test_mode = true
  end

  def mock_auth_hash(vendor)
    return {
      provider: vendor.provider,
      uid: vendor.uid,
      info: {
        email: vendor.email,
        name: vendor.name,
        username: vendor.username
      }
    }
  end

  def login_vendor(vendor)
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(mock_auth_hash(vendor))
    get auth_google_oauth2_callback_path
  end
end
