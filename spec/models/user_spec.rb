require 'spec_helper'

describe User do
  let!(:user) { User.create(:username => 'test', :email => 'test@test.com') }
  
  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  
  it { should allow_value('test1@test.com').for(:email) }
  it { should_not allow_value('test1').for(:email) }
  
  describe 'creating a user for LDAP Authentication' do
    it 'should be successful' do
      user = User.new(:username => 'test1', :email => 'test1@test.com')
      expect { user.save }.to change(User, :count).by(1)
    end
    
    describe 'post create' do
      let!(:user) { User.create(:username => 'test2', :email => 'test2@test.com') }
      
      it 'should not have an encrypted password' do
        user.encrypted_password.should be_blank
      end
    end
  end
  
  describe 'creating a user for Database Authentication' do
    it 'should be successful' do
      user = User.new(:username => 'test3', :email => 'test3@test.com', :password => 'tester', :password_confirmation => 'tester')
      expect { user.save }.to change(User, :count).by(1)
    end
    
    describe 'post create' do
      let!(:user) { User.create(:username => 'test4', :email => 'test4@test.com', :password => 'tester', :password_confirmation => 'tester') }
      
      it 'should have an encrypted password' do
        user.encrypted_password.should_not be_blank
      end 
    end
  end
end
