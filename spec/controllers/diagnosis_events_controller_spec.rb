require 'spec_helper'

describe DiagnosisEventsController do

  describe "GET 'new'" do
    before do
      DiagnosisEvent.stub!(:new).and_return(mock_diagnosis_event(:save => true))
      Patient.stub!(:find).and_return(mock_patient(:save => true))
      DiagnosisCategory.stub!(:all).and_return(
          [mock_diagnosis_category(:save => true)])
      get :new, :patient_id => mock_patient.id
    end

    it { response.should be_success }

    it "should set @patient" do
      assigns[:patient].should equal(mock_patient)
    end

    it "should set @categories" do
      assigns[:categories].should include mock_diagnosis_category
    end

    it "should set @diagnosis_event" do
      assigns[:diagnosis_event].should equal(mock_diagnosis_event)
    end

    it { response.should render_template(:new) }
  end



  describe "POST 'create'" do
    before do
      DiagnosisEvent.stub!(:new).and_return(mock_diagnosis_event(:save => true))
      Diagnosis.stub!(:find).and_return(mock_diagnosis(:save => true, 
        :name => true, :code => true, :description => true))
      Patient.stub!(:find).and_return(mock_patient(:save => true))
      DiagnosisCategory.stub!(:all).and_return(
          [mock_diagnosis_category(:save => true)])
      mock_patient.stub!(:events).and_return([])
      mock_diagnosis_event.stub!(:attributes=)
    end

    describe "always" do
      before do
        post :create,
             :patient_id => mock_patient.id,
             :diagnosis_event => mock_diagnosis_event
      end
        
      it "should set @patient" do
        assigns[:patient].should equal(mock_patient)
      end

    end

    describe "with valid attributes" do
      before do
        mock_diagnosis_event.stub!(:save).and_return(true)
        post :create,
             :patient_id => mock_patient.id,
             :diagnosis_event => mock_diagnosis_event
      end

      it "should create a new diagnosis" do
        assigns[:diagnosis_event].should equal(mock_diagnosis_event)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Diagnosis recorded"
      end
  
      it { response.should redirect_to patient_events_path(mock_patient) }
    end
    
    describe "with invalid attributes" do
      before do
        mock_diagnosis_event.stub!(:save).and_return(false)
        post :create,
             :patient_id => mock_patient.id,
             :diagnosis_event => mock_diagnosis_event
      end

      it "should set @categories" do
        assigns[:categories].should include mock_diagnosis_category
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to make diagnosis"
      end

      it { response.should render_template(:new) }
    end

  end
end

def mock_diagnosis_event(stubs={})
  @mock_diagnosis_event ||= mock_model(DiagnosisEvent, stubs)
end

def mock_patient(stubs={})
  @mock_patient ||= mock_model(Patient, stubs)
end

def mock_diagnosis(stubs={})
  @mock_diagnosis ||= mock_model(Diagnosis, stubs)
end

def mock_diagnosis_category(stubs={})
  @mock_diagnosis_category ||= mock_model(DiagnosisCategory, stubs)
end
