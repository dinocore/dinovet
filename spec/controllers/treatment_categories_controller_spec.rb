require 'spec_helper'

describe TreatmentCategoriesController do
  before do
    TreatmentCategory.stub!(:all).and_return([mock_treatment_category])
    mock_treatment_category.stub!(:name).and_return("name")
  end


  describe "GET 'new'" do
    before do
      TreatmentCategory.stub!(:new).and_return(
        mock_treatment_category(:save => true))
      get :new
    end

    it { response.should be_success }

    it "should set @treatment_category" do
      assigns[:treatment_category].should equal(mock_treatment_category)
    end

    it { response.should render_template(:new) }
  end



  describe "POST 'create'" do
    before do
      TreatmentCategory.stub!(:new).and_return(
        mock_treatment_category(:save => true))
    end

    describe "with valid attributes" do
      before do
        mock_treatment_category.stub!(:save).and_return(true)
        post :create, :treatment_category => mock_treatment_category
      end

      it "should create a new treatment category" do
        assigns[:treatment_category].should equal(mock_treatment_category)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Category created successfully"
      end
  
      it { response.should redirect_to treatments_path }
    end
    
    describe "with invalid attributes" do
      before do
        mock_treatment_category.stub!(:save).and_return(false)
        post :create, :treatment => mock_treatment_category
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to create category"
      end

      it { response.should render_template(:new) }
    end

  end



  describe "GET 'edit'" do
    before do
      TreatmentCategory.stub!(:find).and_return(mock_treatment_category)
      get :edit, :id => mock_treatment_category.id
    end

    it { response.should be_success }
    it { response.should render_template(:edit) }

    it "should set @treatment_category" do
      assigns[:treatment_category].should equal(mock_treatment_category)
    end

  end



  describe "PUT 'update'" do
    before do
      TreatmentCategory.stub!(:find).and_return(mock_treatment_category)
    end

    describe "with valid attributes" do
      before do
        mock_treatment_category.stub!(:update_attributes).and_return(true)
        put :update, :id => mock_treatment_category.id,
          :treatment_category => mock_treatment_category
      end

      it "should set a success message" do
        flash[:notice].should == "Category updated successfully"
      end

      it { response.should redirect_to(treatments_path) }

      it "should set @treatment_category" do
        assigns[:treatment_category].should equal(mock_treatment_category)
      end
    end

    describe "with invalid attributes" do
      before do
        mock_treatment_category.should_receive(
          :update_attributes).and_return(false)
        put :update, :id => mock_treatment_category.id,
          :treatment_category => mock_treatment_category
      end

      it "should set an error message" do
        flash[:error].should == "Failed to update category"
      end

      it { response.should render_template('edit') }
    end

  end


  def mock_treatment_category(stubs={})
    @mock_treatment_category ||= mock_model(TreatmentCategory, stubs)
  end
end
