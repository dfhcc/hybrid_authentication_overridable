require "hybrid_authentication_overridable/version"

module HybridAuthenticationOverridable
  extend ActiveSupport::Concern

  included do
    class_eval do
      validates :username, :presence => true, :uniqueness => true
      validates :email, :presence => true, :uniqueness => true, :format => { :with => /\A[^@]+@[^@]+\z/ }
      validates :password, :presence => true, :confirmation => true, :length => { :minimum => 6 }, :if => :encrypt_password?
      
      before_save :encrypt_password, :if => :encrypt_password?
    end
  end
  
  def password=(new_password)
    @password = new_password
  end
  
  protected
  
  def encrypt_password?
    password.present? && respond_to?(:encrypted_password=) && respond_to?(:password_digest)
  end
  
  def encrypt_password
    self.encrypted_password = password_digest(password) 
  end
end

Devise.add_module(:hybrid_authentication_overridable, 
                  :route => :session,
                  :strategy => false,
                  :controller => :sessions,
                  :model => 'hybrid_authentication_overridable')
