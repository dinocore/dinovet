require 'spec_helper'

describe DiagnosesController do
  before do
    Diagnosis.stub!(:all).and_return([mock_diagnosis])
  end


  describe "GET 'new'" do
    before do
      Diagnosis.stub!(:new).and_return(mock_diagnosis(:save => true))
      get :new
    end

    it { response.should be_success }

    it "should set @diagnosis" do
      assigns[:diagnosis].should equal(mock_diagnosis)
    end

    it { response.should render_template(:new) }
  end

  def mock_diagnosis(stubs={})
    @mock_diagnosis ||= mock_model(Diagnosis, stubs)
  end



  describe "POST 'create'" do
    before do
      Diagnosis.stub!(:new).and_return(mock_diagnosis(:save => true))
    end

    describe "with valid attributes" do
      before do
        mock_diagnosis.stub!(:save).and_return(true)
        post :create, :diagnosis => mock_diagnosis
      end

      it "should create a new diagnosis" do
        assigns[:diagnosis].should equal(mock_diagnosis)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Diagnosis created successfully"
      end
  
      it { response.should redirect_to diagnoses_path }
    end
    
    describe "with invalid attributes" do
      before do
        mock_diagnosis.stub!(:save).and_return(false)
        post :create, :diagnosis => mock_diagnosis
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to create diagnosis"
      end

      it { response.should render_template(:new) }
    end

  end



  describe "GET 'index'" do
    before { get :index }

    it { response.should be_success }

    it "should assign a list of diagnosis to @diagnoses" do
      assigns[:diagnoses].should include mock_diagnosis
    end

    it { response.should render_template(:index) }
  end
end
