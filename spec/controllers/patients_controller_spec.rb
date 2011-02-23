require 'spec_helper'

describe PatientsController do
  before do
    Client.stub!(:find).and_return(mock_client)
    mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
    Patient.stub!(:new).and_return(mock_patient(:save => true))
    Patient.stub!(:all).and_return([mock_patient])
    Patient.stub!(:find).and_return(mock_patient)
    Species.stub!(:all).and_return([mock_species])
    Species.stub!(:where).and_return([mock_species])
    mock_breed.stub!(:name).and_return("breed name")
    mock_species.stub!(:breeds).and_return([mock_breed])
    mock_species.stub!(:list_breeds).and_return([mock_breed.name])
    mock_species.stub!(:name).and_return("species name")
    mock_patient.stub!(:client=).and_return(mock_client)
    mock_patient.stub!(:species).and_return(mock_species)
    mock_patient.stub!(:client).and_return(mock_client)
  end



  describe "GET 'new'" do
    before { get :new, :client_id => mock_client.id }

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

    it "should set @species" do
      assigns[:species].should include mock_species.name
    end

    it "should set @breeds" do
      assigns[:breeds].should include mock_breed.name
    end
  end



  describe "POST 'create'" do
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

      it { response.should redirect_to edit_patient_path(mock_patient) }
                                                    
    end

    describe "from javascript with valid attributes" do
      before do
        mock_patient.stub!(:save).and_return(true)
        put :create, :client_id => mock_client.id, :patient => mock_patient, 
            :format => :js
      end

      it "should set a success message" do
        flash[:notice].should == "Patient created successfully"
      end

      it { response.should render_template(:success) }

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




  describe "GET 'edit'" do
    before { get :edit, :id => mock_patient.id }

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

    it "should set @species" do
      assigns[:species].should include mock_species.name
    end

    it "should set @breeds" do
      assigns[:breeds].should include mock_breed.name
    end

  end



  describe "PUT 'update'" do
    before do
      request.env["HTTP_REFERER"] = edit_patient_path(mock_patient)
    end

    describe "always" do
      before do
        mock_patient.should_receive(:update_attributes)
        put :update, :id => mock_patient.id, :patient => mock_patient
      end

      it "should set @client" do
        assigns[:client].should equal(mock_client)
      end

      it "should set @phone_numbers" do
        assigns[:phone_numbers].should include mock_phone_number
      end

      it "should set @patient" do
        assigns[:patient].should equal(mock_patient)
      end

      it "should set @species" do
        assigns[:species].should include mock_species.name
      end

      it "should set @breeds" do
        assigns[:breeds].should include mock_breed.name
      end
    end

    describe "with valid attributes" do
      before do
        mock_patient.stub!(:update_attributes).and_return(true)
        put :update, :id => mock_patient.id, :patient => mock_patient
      end

      it "should set a success message" do
        flash[:notice].should == "Patient updated successfully"
      end

      it { response.should redirect_to(edit_patient_path(mock_patient)) }
                                                                

      it "should set @patient" do
        assigns[:patient].should equal(mock_patient)
      end
    end

    describe "from javascript with valid attributes" do
      before do
        mock_patient.stub!(:update_attributes).and_return(true)
        put :update, :id => mock_patient.id, :patient => mock_patient, 
            :format => :js
      end

      it "should set a success message" do
        flash[:notice].should == "Patient updated successfully"
      end

      it { response.should redirect_to edit_patient_path(
                                              mock_patient, :format => :js) }

    end

    describe "with invalid attributes" do
      before do
        mock_patient.should_receive(:update_attributes).and_return(false)
        put :update, :id => mock_patient.id, :patient => mock_patient
      end

      it "should set an error message" do
        flash[:error].should == "Failed to update patient"
      end

      it { response.should render_template(:edit) }
    end
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

def mock_species(stubs={})
  @mock_species ||= mock_model(Species, stubs)
end

def mock_breed(stubs={})
  @mock_breed ||= mock_model(Breed, stubs)
end
