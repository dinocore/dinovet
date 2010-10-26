require 'spec_helper'

describe DiagnosisCategory do
  let(:diagnosis_category) { create_diagnosis_category }
  subject { diagnosis_category }
  it_should_behave_like "all categories"

  it { should reference_many(:diagnoses).stored_as(:array) }
          
end

def create_diagnosis_category(parameters = {})
  DiagnosisCategory.new(
    Factory.attributes_for(:diagnosis_category).merge(parameters))
end
