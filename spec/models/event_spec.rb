require 'spec_helper'

describe Event do
  it { should be_embedded_in(:patient).as_inverse_of(:events) }

  describe "#name" do
    it { create_event.name.should == nil }
  end

end

def create_event(parameters = {})
  Event.new(Factory.attributes_for(:event).merge(parameters))
end
