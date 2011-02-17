require 'spec_helper'

describe Employee do
  let(:employee) { create_employee }

  subject { employee }

  it { should be_valid }

  it { should embed_many :phone_numbers }

  it { should validate_presence_of(:title) }
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

  describe "#full_name" do
    it "should return full name in last, first format" do
      employee.full_name.should ==
                        "#{employee.last_name}, #{employee.first_name}"
    end
  end
end

def create_employee(parameters = {})
  Employee.new(Factory.attributes_for(:employee).merge(parameters))
end
