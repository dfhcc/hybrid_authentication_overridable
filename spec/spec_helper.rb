ENV['RAILS_ENV'] = 'test'

require 'active_record'
require 'rspec'
require 'shoulda'

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
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :dbfile => ":memory:")
  
  ActiveRecord::Schema.define(:version => 1) do
    create_table(:users) do |t|
      t.string :username,           :null => false, :default => ""
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      t.timestamps
    end

    add_index :users, :username, :unique => true
    add_index :users, :email,    :unique => true
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

class User < ActiveRecord::Base
  devise :ldap_authentication, :database_authentication, :hybrid_authentication_overridable
  
  attr_accessor :username, :email, :password, :password_confirmation
end