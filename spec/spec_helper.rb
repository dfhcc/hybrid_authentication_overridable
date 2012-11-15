ENV['RAILS_ENV'] = 'test'

require File.expand_path('rails_app/config/environment.rb',  File.dirname(__FILE__))
require 'rspec/rails'
require 'rspec/autorun'
require 'factory_girl'

require File.expand_path('../../lib/hybrid_authentication_overridable', File.dirname(__FILE__))

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each {|f| require f}

RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  
  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end