require 'spec_helper'

describe PhoneNumber do

  it { should validate_presence_of(:number) }
  it { should validate_presence_of(:type)   }

  it { should be_embedded_in(:client).as_inverse_of(:phone_numbers) }

  def create_phone_number(parameters = {})
    PhoneNumber.new(Factory.attributes_for(:phone_number).merge(parameters))
  end
end
