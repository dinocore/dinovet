require 'spec_helper'

describe Client do

  it "creates a new client given valid input" do
    create_client.should be_valid
  end

  it "requires a first name" do
    create_client(:first_name => nil).should_not be_valid
  end

  it "requires a last name" do
    create_client(:last_name => nil).should_not be_valid
  end

  it "requires an address" do
    create_client(:address_1 => nil).should_not be_valid
  end

  it "requires a city" do
    create_client(:city => nil).should_not be_valid
  end

  it "requires a state" do
    create_client(:state => nil).should_not be_valid
  end

  it "requires a zip code" do
    create_client(:zipcode => nil).should_not be_valid
  end

  it "requires a phone number" do
    create_client(:phone => nil).should_not be_valid
  end

  it "requires e-mail address to be of a valid format" do
    create_client(
      :email => 'invalid.address[AT]dinocore.net').should_not be_valid
  end

  it "does not require an e-mail address" do
    create_client(:email => nil).should be_valid
  end

end

def create_client(parameters = {})
  Client.new(Factory.attributes_for(:client).merge(parameters))
end
