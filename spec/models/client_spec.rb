require 'spec_helper'

describe Client do
  let(:client) { create_client }

  subject { client }

  it { should be_valid }

  it { should embed_many :phone_numbers }

  it { should reference_many(:patients) }

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
end

def create_client(parameters = {})
  Client.new(Factory.attributes_for(:client).merge(parameters))
end
