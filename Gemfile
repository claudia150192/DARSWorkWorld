source 'http://rubygems.org'


gem 'rails', '3.2.11'
gem 'cancan'
gem 'less'
gem 'authlogic'
gem 'high_voltage'
gem 'more'
gem 'state_select'
gem 'calendar_date_select', :git => 'https://github.com/paneq/calendar_date_select.git', :branch => 'rails3test'
gem 'prototype_legacy_helper', '0.0.0', :git => 'git://github.com/rails/prototype_legacy_helper.git'
gem 'jquery-rails'
gem 'permanent_records'
gem 'deep_cloneable'
gem 'rvm'
gem 'prawn'
gem 'prawn-graph'
gem 'therubyracer'
#if RUBY_PLATFORM.downcase.include?("cedar")
#    gem 'rb-fsevent'
#    gem 'growl'
#  end

group :production do
  gem 'pg'
end

group :cucumber do
  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails', ">= 0.5.1"
  gem 'cucumber'
  gem 'spork'
  gem 'launchy'    # So you can do Then show me the page
  gem 'growl'
end

group :development, :test do
#  gem 'pg'
  gem 'sqlite3'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'ruby-debug19'
  gem 'growl'
  #gem 'newrelic_rpm'
end

group :test do
  gem 'sqlite3'
#  gem 'autotest'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_girl'
  gem 'factory_girl_rails'
  gem 'gherkin'
  gem 'capybara'
  gem 'guard-cucumber'
  gem 'database_cleaner'
end
