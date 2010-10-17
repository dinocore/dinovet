require 'spec_helper'

describe PatientsController do



  describe "GET 'new'" do
    before do
      Patient.stub!(:new).and_return(mock_patient(:save => true))
      Client.stub!(:find).and_return(mock_client)
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
      get :new, :client_id => mock_client.id
    end

    it { response.should be_success }

    it "should set @client" do
      assigns[:client].should equal(mock_client)
    end

    it "should set @phone_numbers" do
      assigns[:phone_numbers].should include mock_phone_number
    end

    it "should set @patient" do
      assigns[:patient].should equal(mock_patient)
    end
  end



  describe "POST 'create'" do
    before do
      Patient.stub!(:new).and_return(mock_patient(:save => true))
      Client.stub!(:find).and_return(mock_client)
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
    end


    describe "always" do
      before do
        post :create, :client_id => mock_client.id, :patient => mock_patient
      end

      it "should set @client" do
        assigns[:client].should equal(mock_client)
      end
  
      it "should set @phone_numbers" do
        assigns[:phone_numbers].should include mock_phone_number
      end
    end


    describe "with valid attributes" do
      before do
        mock_patient.stub!(:save).and_return(true)
        post :create, :client_id => mock_client.id, :patient => mock_patient
      end

      it "should create a new patient" do
        assigns[:patient].should equal(mock_patient)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Patient created successfully"
      end

      it { response.should redirect_to client_patients_path(mock_client) }
    end

    describe "with invalid attributes" do
      before do
        mock_patient.stub!(:save).and_return(false)
        post :create, :client_id => mock_client.id, :patient => mock_patient
      end
      
      it "should set an error message" do
        flash[:error].should == "Failed to create patient"
      end

      it { response.should render_template(:new) }
    end
  end



  describe "GET 'index'" do
    before(:each) do
      Client.stub!(:find).and_return(mock_client)
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
      Patient.stub!(:all).and_return([mock_patient])
      get :index, :client_id => mock_client.id
    end

    it { response.should be_success }

    it "should set @client" do
      assigns[:client].should equal(mock_client)
    end
  
    it "should set @phone_numbers" do
      assigns[:phone_numbers].should include mock_phone_number
    end

    it "should assign a list of patients to @patients" do
      assigns[:patients].should include mock_patient
    end

    it { response.should render_template(:index) }
  end

end

def mock_patient(stubs={})
  @mock_patient ||= mock_model(Patient, stubs)
end

def mock_client(stubs={})
  @mock_client ||= mock_model(Client, stubs)
end

def mock_phone_number(stubs={})
  @mock_phone_number ||= mock_model(PhoneNumber, stubs)
end
