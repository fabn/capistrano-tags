source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"
gem "capistrano", ">= 2.5.0"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "rspec"
  gem "bundler", "~> 1.0.0"
  gem "jeweler", "~> 1.6.0"
  gem "rcov", ">= 0"
  gem "mocha"
  gem 'autotest-standalone'
  gem 'autotest-rails-pure'
  gem 'zentest-without-autotest'
  if RUBY_PLATFORM.downcase.include?("darwin") # I'm on Mac
    gem 'autotest-fsevent'
    gem 'autotest-growl'
  end
end
