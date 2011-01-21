require 'spec_helper'

describe DiagnosisCategory do
  let(:diagnosis_category) { create_diagnosis_category }
  subject { diagnosis_category }
  it_should_behave_like "all categories"

  it { should have_and_belong_to_many(:diagnoses) }
          
end

def create_diagnosis_category(parameters = {})
  DiagnosisCategory.new(
    Factory.attributes_for(:diagnosis_category).merge(parameters))
end
