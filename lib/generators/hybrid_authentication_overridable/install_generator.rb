module HybridAuthenticationOverridable
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../templates", __FILE__)
    
    class_option :user_model, :type => :string, :default => "user", :desc => "Model to update"
    class_option :update_model, :type => :boolean, :default => true, :desc => "Update model to change to handle dual authentication between ldap and database with overridable"
    
    def update_user_model
      if options.update_model
        gsub_file "app/models/#{options.user_model}.rb", /:database_authenticatable/, ':ldap_authenticatable, :database_authenticatable'
        gsub_file "app/models/#{options.user_model}.rb", /:validatable,/, ':hybrid_authentication_overridable,'
        gsub_file "app/models/#{options.user_model}.rb", /:validatable/, ':hybrid_authentication_overridable'
      end
    end
    
    def create_authentication_fallback
      inject_into_file "config/initializers/devise.rb", devise_authentication_fallback, :after => "Devise.setup do |config|\n"
    end
    
    private
    
    def devise_authentication_fallback
      settings = <<-eof
    config.warden do |manager|
      manager.default_strategies(:scope => :user).unshift :ldap_authenticatable
    end
      eof
      
      settings
    end
  end
end