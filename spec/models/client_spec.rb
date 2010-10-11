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
    create_client(:phone_numbers => nil).should_not be_valid
  end

  it "requires e-mail address to be of a valid format" do
    create_client(
      :email => 'invalid.address[AT]dinocore.net').should_not be_valid
  end

  it "does not require an e-mail address" do
    create_client(:email => nil).should be_valid
  end

  it "embeds many phone numbers" do
    association = Client.associations['phone_numbers']
    association.klass.should == (PhoneNumber)
    association.association.should == (Mongoid::Associations::EmbedsMany)
  end

  describe "#search" do
    before(:each) do
      5.times { create_client.save! }
    end

    it "finds clients by last name" do
      last_name = "Smith"
      client = create_client(:last_name => last_name)
      client.save!
      Client.search(last_name).inject([]) { |a, c| a << c }.should == [client]
    end

    it "finds clients by first name" do
      first_name = "Holden"
      client = create_client(:first_name => first_name)
      client.save!
      Client.search(first_name).inject([]) { |a, c| a << c }.should == [client]
    end

    it "finds clients by street address" do
      address_1 = "1 Fake St."
      client = create_client(:address_1 => address_1)
      client.save!
      Client.search(address_1).inject([]) { |a, c| a << c }.should == [client]
    end

    it "finds clients by phone number" do
      pending
      number = "555-555-5555"
      phone = PhoneNumber.from_string(number)
      client = create_client(:phone_numbers => [phone])
      client.save!
      Client.search(number).inject([]) { |a, c| 
        a << c }.should == [client]
    end

    it "finds clients by e-mail address" do
      email = "crocodile@dinocore.net"
      client = create_client(:email => email)
      client.save!
      Client.search(email).inject([]) { |a, c| a << c }.should == [client]
    end
  end

end

def create_client(parameters = {})
  Client.new(Factory.attributes_for(:client).merge(parameters))
end
