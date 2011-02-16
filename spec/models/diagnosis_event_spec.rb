require 'spec_helper'

describe DiagnosisEvent do
  it { should be_a_kind_of(Event)  }
  it { should have_fields(:name, :code, :description, :comment) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:diagnosis_id) }
  it { should_not validate_uniqueness_of(:name) }
  it { should_not validate_uniqueness_of(:code) }

end

def create_diagnosis_event(parameters = {})
  Event.new(Factory.attributes_for(:diagnosis_event).merge(parameters))
end
