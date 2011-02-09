require 'spec_helper'

describe DiagnosisCategoriesController do
  before do
    DiagnosisCategory.stub!(:all).and_return([mock_diagnosis_category])
    mock_diagnosis_category.stub!(:name).and_return("name")
  end


  describe "GET 'new'" do
    before do
      DiagnosisCategory.stub!(:new).and_return(
        mock_diagnosis_category(:save => true))
      get :new
    end

    it { response.should be_success }

    it "should set @diagnosis_category" do
      assigns[:diagnosis_category].should equal(mock_diagnosis_category)
    end

    it { response.should render_template(:new) }
  end



  describe "POST 'create'" do
    before do
      DiagnosisCategory.stub!(:new).and_return(
        mock_diagnosis_category(:save => true))
    end

    describe "with valid attributes" do
      before do
        mock_diagnosis_category.stub!(:save).and_return(true)
        post :create, :diagnosis_category => mock_diagnosis_category
      end

      it "should create a new diagnosis category" do
        assigns[:diagnosis_category].should equal(mock_diagnosis_category)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Category created successfully"
      end
  
      it { response.should redirect_to diagnoses_path }
    end
    
    describe "with invalid attributes" do
      before do
        mock_diagnosis_category.stub!(:save).and_return(false)
        post :create, :diagnosis => mock_diagnosis_category
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to create category"
      end

      it { response.should render_template(:new) }
    end

  end



  describe "GET 'edit'" do
    before do
      DiagnosisCategory.stub!(:find).and_return(mock_diagnosis_category)
      get :edit, :id => mock_diagnosis_category.id
    end

    it { response.should be_success }
    it { response.should render_template(:edit) }

    it "should set @diagnosis_category" do
      assigns[:diagnosis_category].should equal(mock_diagnosis_category)
    end

  end



  describe "PUT 'update'" do
    before do
      DiagnosisCategory.stub!(:find).and_return(mock_diagnosis_category)
    end

    describe "with valid attributes" do
      before do
        mock_diagnosis_category.stub!(:update_attributes).and_return(true)
        put :update, :id => mock_diagnosis_category.id,
          :diagnosis_category => mock_diagnosis_category
      end

      it "should set a success message" do
        flash[:notice].should == "Category updated successfully"
      end

      it { response.should redirect_to(diagnoses_path) }

      it "should set @diagnosis_category" do
        assigns[:diagnosis_category].should equal(mock_diagnosis_category)
      end
    end

    describe "with invalid attributes" do
      before do
        mock_diagnosis_category.should_receive(
          :update_attributes).and_return(false)
        put :update, :id => mock_diagnosis_category.id,
          :diagnosis_category => mock_diagnosis_category
      end

      it "should set an error message" do
        flash[:error].should == "Failed to update category"
      end

      it { response.should render_template('edit') }
    end

  end


  def mock_diagnosis_category(stubs={})
    @mock_diagnosis_category ||= mock_model(DiagnosisCategory, stubs)
  end
end
