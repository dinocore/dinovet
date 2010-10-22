require 'spec_helper'

describe Diagnosis do
  let(:diagnosis) { create_diagnosis }
  subject { diagnosis }

  it { should be_valid }

  it { should have_fields(:name, :code, :description) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:code) }
end

def create_diagnosis(parameters = {})
  Diagnosis.new(Factory.attributes_for(:diagnosis).merge(parameters))
end
