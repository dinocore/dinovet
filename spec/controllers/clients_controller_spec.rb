require 'spec_helper'

describe ClientsController do

  before(:each) do
    Client.stub!(:new).and_return(@client = mock_model(Client, :save => true))
  end

  describe "GET 'new'" do
    it "is successful" do
      get :new
      response.should be_success
    end

    it "sets @client" do
      Client.should_receive(:new).and_return(@client)
      get :new
      assigns[:client].should equal(@client)
    end
  end



  describe "POST 'create'" do

    describe "with valid attributes" do
      it "creates a new client" do
        Client.should_receive(:new).with(@client).and_return(@client)
        post :create, :client => @client
        assigns[:client].should equal(@client)
      end
  
      it "sets a success message" do
        post :create, :client => @client
        flash[:notice].should == "Client added successfully"
      end
  
      it "redirects to clients list" do
        post :create, :client => @client
        response.should redirect_to clients_path
      end
    end

    
    describe "with invalid attributes" do
      it "sets an error message" do
        @client.stub!(:save).and_return(false)
        post :create
        flash.now[:error].should == "Failed to create client"
      end

      it "redisplays the new client form" do
        @client.stub!(:save).and_return(false)
        post :create
        response.should render_template(:new)
      end
    end

  end



  describe "GET 'index'" do
    it "is successful" do
      get :index
      response.should be_success
    end
  end

end
