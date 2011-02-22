require 'spec_helper'

describe Event do
  it { should be_embedded_in(:patient).as_inverse_of(:events) }

  describe "#name" do
    it { create_event.name.should == nil }
  end

  describe ".diagnoses" do
    let(:diagnosis_event) { Factory.create(:diagnosis_event) }
    let(:event) { Factory.create(:event) }
    let(:events) { Event.all.diagoses }

    it "should include only diagnosis events" do
      events.should     include diagnosis_event
      events.should_not include event
    end
  end

end

def create_event(parameters = {})
  Event.new(Factory.attributes_for(:event).merge(parameters))
end
