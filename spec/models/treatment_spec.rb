require 'spec_helper'

describe Treatment do
  let(:treatment) { create_treatment }
  subject { treatment }

  it { should be_valid }

  it { should have_and_belong_to_many(:categories) }
  it "should alias treatment_categories to categories" do
    Treatment.instance_method(:categories).should == 
      Treatment.instance_method(:treatment_categories)
  end

  it { should have_fields(:name, :code, :description) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:code) }
end

def create_treatment(parameters = {})
  Treatment.new(Factory.attributes_for(:treatment).merge(parameters))
end
