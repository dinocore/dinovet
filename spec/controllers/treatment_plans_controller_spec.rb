require 'spec_helper'

describe TreatmentPlansController do
  before do
    Patient.stub!(:find).and_return(mock_patient)
    TreatmentCategory.stub!(:all).and_return([mock_treatment_category])
  end

  describe "GET 'new'" do
    before do
      TreatmentPlan.stub!(:new).and_return(mock_treatment_plan)
      get :new, :patient_id => mock_patient.id
    end

    it { response.should be_success }

    it "should set @patient" do
      assigns[:patient].should equal(mock_patient)
    end

    it "should set @treatment_categories" do
      assigns[:treatment_categories].should include mock_treatment_category
    end

    it "should set @treatment_plan" do
      assigns[:treatment_plan].should equal(mock_treatment_plan)
    end

    it { response.should render_template(:new) }
  end



  describe "POST 'create'" do

    describe "always" do
      before do
        TreatmentPlan.stub!(:new).and_return(mock_treatment_plan)
        mock_treatment_plan.stub!(:save).and_return(true)
        post :create,
             :patient_id     => mock_patient.id,
             :treatment_plan => mock_treatment_plan
      end
        
      it "should set @patient" do
        assigns[:patient].should equal(mock_patient)
      end

    end

    describe "with valid attributes" do
      before do
        TreatmentPlan.stub!(:new).and_return(mock_treatment_plan)
        mock_treatment_plan.stub!(:save).and_return(true)
        post :create,
             :patient_id      => mock_patient.id,
             :treatment_plan  => mock_treatment_plan
      end

      it "should create a new treatment plan" do
        assigns[:treatment_plan].should equal(mock_treatment_plan)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Treatment plan created successfully"
      end
  
      it { response.should redirect_to 
                    patient_treatment_plans_path(mock_patient) }
    end
    
    describe "with invalid attributes" do
      before do
        TreatmentPlan.stub!(:new).and_return(mock_treatment_plan)
        mock_treatment_plan.stub!(:save).and_return(false)
        post :create,
             :patient_id      => mock_patient.id,
             :treatment_plan  => mock_treatment_plan
      end

      it "should set @categories" do
        assigns[:treatment_categories].should include mock_treatment_category
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to create treatment plan"
      end

      it { response.should render_template(:new) }
    end

  end
end

def mock_patient(stubs={})
  @mock_patient ||= mock_model(Patient, stubs)
end

def mock_treatment_plan(stubs={})
  @mock_treatment_plan ||= mock_model(TreatmentPlan, stubs)
end

def mock_treatment_category(stubs={})
  @mock_treatment_category ||= mock_model(TreatmentCategory, stubs)
end
