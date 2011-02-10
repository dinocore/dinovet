require 'spec_helper'

describe Employee do
  let(:employee) { create_employee }

  subject { employee }

  it { should be_valid }

  it { should embed_many :phone_numbers }

  it { should reference_many(:patients) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:address_1) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:zipcode) }
  it { should validate_presence_of(:phone_numbers) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should validate_format_of(:email).
          to_allow("valid@dinocore.net").
          not_to_allow("invlaid[AT]dinocore.net") }
  it { should_not validate_presence_of(:email) }


  describe "::search" do
    before { 5.times { create_employee.save! } }
    
    it "should find employees by last name" do
      last_name = "Smith"
      employee = create_employee(:last_name => last_name)
      employee.save!
      Employee.search(last_name).should include employee
    end

    it "should find employees by first name" do
      first_name = "Holden"
      (employee = create_employee(:first_name => first_name)).save!
      Employee.search(first_name).should include employee
    end

    it "should find employees by street address" do
      address_1 = "1 Fake St."
      (employee = create_employee(:address_1 => address_1)).save!
      Employee.search(address_1).should include employee
    end

    it "should find employees by phone number" do
      number = "555-555-5555"
      phone = Factory.build(:phone_number, :number => number)
      (employee = create_employee(:phone_numbers => [phone])).save!
      Employee.search(number).should include employee
    end

    it "should find employees by e-mail address" do
      email = "crocodile@dinocore.net"
      (employee = create_employee(:email => email)).save!
      Employee.search(email).should include employee
    end

    it "should find employees by username" do
      username = "holden"
      (emplyee = create_employee(:username => username)).save!
      Employee.search(username).should include employee
    end
  end
end

def create_employee(parameters = {})
  Employee.new(Factory.attributes_for(:employee).merge(parameters))
end
