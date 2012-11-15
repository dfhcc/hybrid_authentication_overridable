ENV['RAILS_ENV'] = 'test'

require 'sqlite3'
require 'active_record'
require 'rspec'
require 'shoulda'

require 'devise'
require 'devise_ldap_authenticatable'

require File.expand_path('../lib/hybrid_authentication_overridable', File.dirname(__FILE__))

Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].each {|f| require f}

RSpec.configure do |config|  
  config.before(:suite) do
    setup_db
  end
  
  config.after(:suite) do
    teardown_db
  end
end

def setup_db
  puts "\nSetting up the database...\n"
  
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => ":memory:")
  
  ActiveRecord::Schema.define(:version => 1) do
    create_table(:users) do |t|
      t.string :username,           :null => false, :default => ""
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      t.timestamps
    end
  end
end

def teardown_db
  puts "\nTearing down the database...\n"
  
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class User < ActiveRecord::Base
  devise :hybrid_authentication_overridable
  
  attr_accessor :username, :email, :password, :password_confirmation
end
