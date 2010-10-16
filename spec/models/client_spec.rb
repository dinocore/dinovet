require 'spec_helper'

describe Client do
  let(:client) { create_client }

  subject { client }

  it { should be_valid }

  it { should embed_many :phone_numbers }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:address_1) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:phone_numbers) }
  it { should validate_format_of(:email).
          to_allow("valid@dinocore.net").
          not_to_allow("invlaid[AT]dinocore.net") }
  it { should_not validate_presence_of(:email) }


  describe "::search" do
    before { 5.times { create_client.save! } }
    
    it "should find clients by last name" do
      last_name = "Smith"
      client = create_client(:last_name => last_name)
      client.save!
      Client.search(last_name).should include client
    end

    it "should find clients by first name" do
      first_name = "Holden"
      (client = create_client(:first_name => first_name)).save!
      Client.search(first_name).should include client
    end

    it "should find clients by street address" do
      address_1 = "1 Fake St."
      (client = create_client(:address_1 => address_1)).save!
      Client.search(address_1).should include client
    end

    it "should find clients by phone number" do
      number = "555-555-5555"
      phone = Factory.build(:phone_number, :number => number)
      (client = create_client(:phone_numbers => [phone])).save!
      Client.search(number).should include client
    end

    it "should find clients by e-mail address" do
      email = "crocodile@dinocore.net"
      (client = create_client(:email => email)).save!
      Client.search(email).should include client
    end
  end
end

def create_client(parameters = {})
  Client.new(Factory.attributes_for(:client).merge(parameters))
end
