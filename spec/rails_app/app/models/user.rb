class User < ActiveRecord::Base
  devise :ldap_authenticatable, :database_authenticatable, :rememberable, :trackable, :hybrid_authentication_overridable

  attr_accessible :username, :email, :password, :password_confirmation, :remember_me
end
