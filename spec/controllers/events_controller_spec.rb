require 'spec_helper'

describe EventsController do
  before do
    Patient.stub!(:find).and_return(mock_patient)
    mock_patient.stub!(:events).and_return([mock_event])
  end

  describe "GET 'index'" do
    before { get :index, :patient_id => mock_patient.id }

    it { response.should be_success }

    it "should set @patient" do
      assigns[:patient].should equal(mock_patient)
    end
  
    it "should assign a list of events to @events" do
      assigns[:events].should include mock_event
    end

    it { response.should render_template(:index) }
  end
end

def mock_event(stubs={})
  @mock_event ||= mock_model(Event, stubs)
end

def mock_patient(stubs={})
  @mock_patient ||= mock_model(Patient, stubs)
end
