require 'spec_helper'

describe ClientsController do



  describe "GET 'new'" do
    before(:each) do
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
    before(:each) do
      Client.stub!(:find).with(1).and_return(mock_client)
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
      get :edit, :id => 1
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
    before(:each) do
      Client.stub!(:find).with(1).and_return(mock_client)
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
    end

    describe "with valid attributes" do
      before(:each) do
        mock_client.stub!(:update_attributes).and_return(true)
        put :update, :id => 1, :client => mock_client
      end

      it { response.should redirect_to(client_path(mock_client)) }

      it "should set @client" do
        assigns[:client].should equal(mock_client)
      end

      it "should set @phone_numbers" do
        assigns[:phone_numbers].should include mock_phone_number
      end
    end

    describe "with invalid attributes" do
      before(:each) do
        mock_client.should_receive(:update_attributes).and_return(false)
        put :update, :id => 1, :client => mock_client
      end

      it { response.should render_template('edit') }
    end

  end



  describe "GET 'show'" do
    before(:each) do
      Client.stub!(:find).with(1).and_return(mock_client)
      get :show, :id => 1
    end

    it { response.should be_success }

    it "should set @client" do
      assigns[:client].should == mock_client
    end
  end



  describe "POST 'create'" do
    before(:each) do
      Client.stub!(:new).and_return(mock_client(:save => true))
      mock_client.stub!(:phone_numbers).and_return([mock_phone_number])
    end

    it "should set @phone_numbers" do
      post :create, :client => mock_client
      assigns[:phone_numbers].should include mock_phone_number
    end

    describe "with valid attributes" do
      before(:each) do
        mock_client.stub!(:save).and_return(true)
        post :create, :client => mock_client
      end

      it "should create a new client" do
        assigns[:client].should equal(mock_client)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Client added successfully"
      end
  
      it { response.should redirect_to clients_path }
    end
    
    describe "with invalid attributes" do
      before(:each) do
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
    before(:each) do
      Client.stub!(:search).and_return([mock_client])
      get :index, :search => "test"
    end

    it { response.should be_success }

    it "should assign a list of clients to @clients" do
      assigns[:clients].should include mock_client
    end

    it "should assign current search term to @search" do
      assigns[:search].should == "test"
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
