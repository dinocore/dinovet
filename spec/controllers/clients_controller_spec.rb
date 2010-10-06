require 'spec_helper'

describe ClientsController do

  def mock_client(stubs={})
    @mock_client ||= mock_model(Client, stubs)
  end

  describe "GET 'new'" do
    before(:each) do
      Client.stub!(:new).and_return(mock_client(:save => true))
    end

    it "is successful" do
      get :new
      response.should be_success
    end

    it "sets @client" do
      Client.should_receive(:new).and_return(mock_client)
      get :new
      assigns[:client].should equal(mock_client)
    end
  end


  describe "GET 'edit'" do
    before(:each) do
      Client.stub!(:find).with(1).and_return(mock_client)
    end

    it "is successful" do
      get :edit, :id => 1 
      response.should be_success
    end

    it "sets @client" do
      Client.should_receive(:find).with(1).and_return(mock_client)
      get :edit, :id => 1
      assigns[:client].should == mock_client
    end
  end


  describe "PUT 'update'" do
    before(:each) do
      Client.stub!(:find).with(1).and_return(mock_client)
    end

    describe "with valid attributes" do
      before(:each) do
        mock_client.should_receive(:update_attributes).and_return(true)
      end

      it "redirects to show" do
        put :update, :id => 1, :client => {}
        response.should redirect_to(client_path(mock_client))
      end

      it "sets @client" do
        put :update, :id => 1, :client => {}
        assigns[:client].should == mock_client
      end
    end

    describe "with invalid attributes" do
      before(:each) do
        mock_client.should_receive(:update_attributes).and_return(false)
      end

      it "re-renders edit" do
        put :update, :id => 1, :client => {}
        response.should render_template('edit')
      end

    end

  end


  describe "GET 'show'" do
    before(:each) do
      Client.stub!(:find).with(1).and_return(mock_client)
    end

    it "sets @client" do
      get :show, :id => 1
      assigns[:client].should == mock_client
    end
  end


  describe "POST 'create'" do
    before(:each) do
      Client.stub!(:new).and_return(mock_client(:save => true))
    end

    describe "with valid attributes" do
      it "creates a new client" do
        Client.should_receive(:new).with(mock_client).and_return(mock_client)
        post :create, :client => mock_client
        assigns[:client].should equal(mock_client)
      end
  
      it "sets a success message" do
        post :create, :client => mock_client
        flash[:notice].should == "Client added successfully"
      end
  
      it "redirects to clients list" do
        post :create, :client => mock_client
        response.should redirect_to clients_path
      end
    end

    
    describe "with invalid attributes" do
      it "sets an error message" do
        mock_client.stub!(:save).and_return(false)
        post :create
        flash.now[:error].should == "Failed to create client"
      end

      it "redisplays the new client form" do
        mock_client.stub!(:save).and_return(false)
        post :create
        response.should render_template(:new)
      end
    end

  end



  describe "GET 'index'" do
    before(:each) do
      Client.stub!(:all).and_return([mock_client])
    end

    it "is successful" do
      get :index
      response.should be_success
    end

    it "assigns a list of clients to @clients" do
      get :index
      assigns[:clients].should == [mock_client]
    end
  end

end
