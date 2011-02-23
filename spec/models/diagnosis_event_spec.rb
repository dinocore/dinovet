require 'spec_helper'

describe DiagnosisEvent do
  it { should be_a_kind_of(Event)  }
  it { should have_fields(:name, :code, :description, :comment) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should_not validate_uniqueness_of(:name) }
  it { should_not validate_uniqueness_of(:code) }

  context "on create" do
    context "without a daignosis_id" do
      let(:event) { create_diagnosis_event(:diagnosis_id => nil) }

      it "should require a diagnosis_id" do
        event = create_diagnosis_event(:diagnosis_id => nil)
        event.should_not be_valid
      end
    end

    context "with a diagnosis_id" do
      before do
        @diagnosis = create_diagnosis
        @diagnosis.save
        @event =
          create_diagnosis_event(:diagnosis_id => @diagnosis.id,
              :name => nil, :code => nil, :description => nil)
      end

      it "should copy the diagnosis data" do
        @event.save.should == true
        @event.name.should == @diagnosis.name
        @event.code.should == @diagnosis.code
        @event.description.should == @diagnosis.description
      end
    end
  end

  context "on update" do
    before do
      @diagnosis = create_diagnosis
      @diagnosis.save
      @event = create_diagnosis_event(:diagnosis_id => @diagnosis.id)
      @event.save
    end

    it "should not require a diagnosis_id" do
      @event.diagnosis_id = nil
      @event.should be_valid
    end
  end

  describe "#type" do
    it { create_diagnosis_event.type.should == "Diagnosis" }
  end

end

def create_diagnosis_event(parameters = {})
  DiagnosisEvent.new(Factory.attributes_for(:diagnosis_event).merge(parameters))
end

def create_diagnosis(parameters = {})
  Diagnosis.new(Factory.attributes_for(:diagnosis).merge(parameters))
end
