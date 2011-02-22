require 'spec_helper'

describe TreatmentsController do
  before do
    Treatment.stub!(:all).and_return([mock_treatment])
    TreatmentCategory.stub!(:all).and_return([mock_treatment_category])
    TreatmentCategory.stub!(:find).and_return(mock_treatment_category)
    mock_treatment_category.stub!(:treatments).and_return([mock_treatment])
    mock_treatment.stub!(:save).and_return(true)
    mock_treatment.stub!(:categories).and_return([mock_treatment_category])
    mock_treatment_category.stub!(:name).and_return("name")
    mock_treatment_category.stub!(:save).and_return(true)
    mock_treatment_category.stub!(:treatment_ids).and_return(
        [mock_treatment.id])
    mock_treatment.stub!(:attributes).and_return(
        Factory.attributes_for(:treatment).merge(
        {:category_ids => [mock_treatment_category.id]}))
  end


  describe "GET 'new'" do
    before do
      Treatment.stub!(:new).and_return(mock_treatment(:save => true))
      get :new
    end

    it { response.should be_success }

    it "should set @treatment" do
      assigns[:treatment].should equal(mock_treatment)
    end

    it "should set @categories" do
      assigns[:categories].should == 
          [[mock_treatment_category.name, mock_treatment_category.id]]
    end

    it { response.should render_template(:new) }
  end



  describe "POST 'create'" do
    before do
      Treatment.stub!(:new).and_return(mock_treatment(:save => true))
    end

    describe "with valid attributes" do
      before do
        mock_treatment.stub!(:save).and_return(true)
        post :create, :treatment => mock_treatment.attributes
      end

      it "should create a new treatment" do
        assigns[:treatment].should equal(mock_treatment)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Treatment created successfully"
      end
  
      it { response.should redirect_to treatments_path }
    end
    
    describe "with invalid attributes" do
      before do
        mock_treatment.stub!(:save).and_return(false)
        post :create, :treatment => mock_treatment
      end

      it "should set @categories" do
        assigns[:categories].should == 
            [[mock_treatment_category.name, mock_treatment_category.id]]
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to create treatment"
      end

      it { response.should render_template(:new) }
    end

  end



  describe "GET 'index'" do
    before { get :index }

    it { response.should be_success }

    it "should assign a list of treatment to @treatments" do
      assigns[:treatments].should include mock_treatment
    end

    it "should assign a list of categories to @categories" do
      assigns[:categories].should include mock_treatment_category
    end

    it { response.should render_template(:index) }
  end



  describe "GET 'edit'" do
    before do
      Treatment.stub!(:find).and_return(mock_treatment)
      get :edit, :id => mock_treatment.id
    end

    it { response.should be_success }
    it { response.should render_template(:edit) }

    it "should set @treatment" do
      assigns[:treatment].should equal(mock_treatment)
    end

    it "should set @categories" do
      assigns[:categories].should == 
        [[mock_treatment_category.name, mock_treatment_category.id]]
    end

  end



  describe "PUT 'update'" do
    before do
      Treatment.stub!(:find).and_return(mock_treatment)
    end

    describe "with valid attributes" do
      before do
        mock_treatment.stub!(:update_attributes).and_return(true)
        mock_treatment_category.stub!(:save).and_return(true)
        put :update, :id => mock_treatment.id, :treatment => mock_treatment
      end

      it "should set a success message" do
        flash[:notice].should == "Treatment updated successfully"
      end

      it { response.should redirect_to(treatments_path) }

      it "should set @treatment" do
        assigns[:treatment].should equal(mock_treatment)
      end
    end

    describe "with invalid attributes" do
      before do
        mock_treatment.should_receive(:update_attributes).and_return(false)
        put :update, :id => mock_treatment.id, :treatment => mock_treatment
      end

      it "should set @categories" do
        assigns[:categories].should == 
            [[mock_treatment_category.name, mock_treatment_category.id]]
      end

      it "should set an error message" do
        flash[:error].should == "Failed to update treatment"
      end

      it { response.should render_template('edit') }
    end

  end

end


def mock_treatment(stubs={})
  @mock_treatment ||= mock_model(Treatment, stubs)
end

def mock_treatment_category(stubs={})
  @mock_treatment_category ||= mock_model(TreatmentCategory, stubs)
end
