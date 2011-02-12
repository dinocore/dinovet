require 'spec_helper'

describe ClientsController do
  disconnect_sunspot



  describe "GET 'new'" do
    before do
      Client.stub!(:new).and_return(mock_client(:save => true))
      PhoneNumber.stub!(:new).and_return(mock_phone_number)
      mock_phone_number.stub!(:<<).and_return([mock_phone_number])
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
      get :new
    end

    it { response.should be_success }

    it "should set @client" do
      assigns[:client].should equal(mock_client)
    end

    it "should set @phone_numbers" do
      assigns[:phone_numbers].should include mock_phone_number
    end
  end



  describe "GET 'edit'" do
    before do
      Client.stub!(:find).with(mock_client.id).and_return(mock_client)
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
      get :edit, :id => mock_client.id
    end

    it { response.should be_success }

    it "should set @client" do
      assigns[:client].should equal(mock_client)
    end

    it "should set @phone_numbers" do
      assigns[:phone_numbers].should include mock_phone_number
    end
  end



  describe "PUT 'update'" do
    before do
      request.env["HTTP_REFERER"] = 
          edit_client_path(mock_client)
      Client.stub!(:find).with(mock_client.id).and_return(mock_client)
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
    end

    describe "with valid attributes" do
      before do
        mock_client.stub!(:update_attributes).and_return(true)
        put :update, :id => mock_client.id, :client => mock_client
      end

      it "should set a success message" do
        flash[:notice].should == "Client updated successfully"
      end

      it { response.should redirect_to(edit_client_path(mock_client)) }

      it "should set @client" do
        assigns[:client].should equal(mock_client)
      end

      it "should set @phone_numbers" do
        assigns[:phone_numbers].should include mock_phone_number
      end
    end

    describe "from javascript with valid attributes" do
      before do
        mock_client.stub!(:update_attributes).and_return(true)
        put :update, :id => mock_client.id, :client => mock_client, 
            :format => :js
      end

      it "should set a success message" do
        flash[:notice].should == "Client updated successfully"
      end

      it { response.should redirect_to edit_client_path(
                                              mock_client, :format => :js) }

    end

    describe "with invalid attributes" do
      before do
        mock_client.should_receive(:update_attributes).and_return(false)
        put :update, :id => mock_client.id, :client => mock_client
      end

      it "should set an error message" do
        flash[:error].should == "Failed to update client"
      end

      it { response.should render_template('edit') }
    end

  end



  describe "POST 'create'" do
    before do
      Client.stub!(:new).and_return(mock_client(:save => true))
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
    end

    it "should set @phone_numbers" do
      post :create, :client => mock_client
      assigns[:phone_numbers].should include mock_phone_number
    end

    describe "with valid attributes" do
      before do
        mock_client.stub!(:save).and_return(true)
        post :create, :client => mock_client
      end

      it "should create a new client" do
        assigns[:client].should equal(mock_client)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Client added successfully"
      end
  
      it { response.should redirect_to edit_client_path(mock_client) }
    end

    describe "from javascript with valid attributes" do
      before do
        mock_client.stub!(:save).and_return(true)
        put :create, :client => mock_client, :format => :js
      end

      it "should set a success message" do
        flash[:notice].should == "Client added successfully"
      end

      it { response.should redirect_to edit_client_path(
                                              mock_client, :format => :js) }

    end
    
    describe "with invalid attributes" do
      before do
        mock_client.stub!(:save).and_return(false)
        post :create, :client => mock_client
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to create client"
      end

      it { response.should render_template(:new) }
    end

  end



  describe "GET 'index'" do
    before do
      Client.stub!(:all).and_return([mock_client])
      get :index
    end

    it { response.should be_success }

    it "should assign a list of clients to @clients" do
      assigns[:clients].should include mock_client
    end

    it { response.should render_template(:index) }
  end



  def mock_client(stubs={})
    @mock_client ||= mock_model(Client, stubs)
  end

  def mock_phone_number(stubs={})
    @mock_phone_Number ||= mock_model(PhoneNumber, stubs)
  end
end
