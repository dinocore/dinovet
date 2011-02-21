require 'spec_helper'

describe TreatmentPlan do
  let(:treatment_plan) { create_treatment_plan }
  subject { treatment_plan }

  it { should be_valid }
end

def create_treatment_plan(parameters = {})
  TreatmentPlan.new(Factory.attributes_for(:treatment_plan).merge(parameters))
end
