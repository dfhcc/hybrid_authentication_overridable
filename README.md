# HybridAuthenticationOverridable

Devise Hybrid Authentication

This gem provides overrides for Devise in order to get LDAP and Database Authentication to work nicely with each other.

This library depends on:

[Devise](https://github.com/plataformatec/devise)

[Devise LDAP Authenticatable](https://github.com/cschiewek/devise_ldap_authenticatable)

## Usage

- Install the gem.
- Add Devise initialize

      ```
      rails g devise:install
      ```
      
- Add Devise User Model

      ```
      rails g devise User
      ```
      
- Add extra fields (customize the User to your needs) and then migrate

      ```
      rake db:migrate
      ```
      
- Add the Devise LDAP configurations

      ```
      rails g devise_ldap_authenticatable:install
      ```

- Configure config/ldap.yml
- Run the hybrid_authentication_overridable installer

      ```
      rails g hybrid_authentication_overridable:install
      ```
      
## TODOs

- Write spec tests

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
