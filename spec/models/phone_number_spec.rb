require 'spec_helper'

describe PhoneNumber do

  it { should validate_presence_of(:area_code) }
  it { should validate_presence_of(:prefix)    }
  it { should validate_presence_of(:suffix)    }
  it { should validate_presence_of(:type)      }

  it { should validate_format_of(:area_code).to_allow('123').not_to_allow('12') }
  it { should validate_format_of(:prefix).to_allow('123').not_to_allow('12')    }
  it { should validate_format_of(:suffix).to_allow('1234').not_to_allow('123')  }

  it { should validate_numericality_of(:country_code) }
  it { should validate_numericality_of(:extension)    }

  it { should have_fields(:country_code, :extension) }

  it { should be_embedded_in(:client).as_inverse_of(:phone_numbers) }

  describe "#from_string" do
    describe "given a string of format ###-###-####" do
      before(:each) do
        @area_code = "555"
        @prefix = "444"
        @suffix = "3333"
        @number = PhoneNumber.from_string("#{@area_code}-#{@prefix}-#{@suffix}")
      end

      it "returns an object of type PhoneNumber" do
        @number.should be_an_instance_of PhoneNumber
      end

      it "correctly parses the area_code" do
        @number.area_code.should == @area_code
      end

      it "correctly parses the prefix" do
        @number.prefix.should == @prefix
      end

      it "correctly parses the suffix" do
        @number.suffix.should == @suffix
      end
    end
  end

  describe "#to_s" do
    it "returns a string representation of the phone number" do
      number = create_phone_number
      string = "#{number.country_code}" +
               "#{number.area_code   }" +
               "#{number.prefix      }" +
               "#{number.suffix      }"
      string += "x#{number.extension}" unless number.extension.blank?
      number.to_s.should == string
    end
  end

  def create_phone_number(parameters = {})
    PhoneNumber.new(Factory.attributes_for(:phone_number).merge(parameters))
  end

end
