require 'spec_helper'

def create_user
  User.new( :email => 'test@prueba.com',
            :name => 'Fulano',
            :surname => 'DeTal',
            :birthday => Time.now - 933120000,
            :password => 'letmein')
end

describe User do 
  
  before(:each) do
    DatabaseCleaner.clean
  end


  let(:user){create_user}

  it "Create User" do
    user.save.should  be_true
  end

  it "Validate User data" do
    user.save
    t = Time.now - 933120000
    u = User.first
    u.email.should == 'test@prueba.com'
    u.name.should == 'Fulano'
    u.surname.should == 'DeTal'
    u.birthday.should == Date.parse(t.strftime("%a, %d %b %Y"))
  end

  it "validate autentication" do
    user.save
    user.authenticate('test@prueba.com','letmein').should_not be_nil 
  end


end