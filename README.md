# HybridAuthenticationOverridable

Devise Hybrid Authentication

This gem provides overrides for Devise in order to get LDAP and Database Authentication to work nicely with each other.

## Usage

- Install the gem.
- In your User model 

      ```
      class User < ActiveRecord::Base
        devise :ldap_authenticatable, :database_authenticatable, :rememberable, :trackable, :ldap_database_overridable
        
        attr_accessible :username, :email, :password, :password_confirmation, :remember_me
      end
      ```
      
- In the Devise initializer add:

      ```
      config.warden do |manager|
        manager.default_strategies(:scope => :user).unshift :ldap_authenticatable
      end
      ```
      


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
