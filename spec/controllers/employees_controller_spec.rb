require 'spec_helper'

describe EmployeesController do



  describe "GET 'new'" do
    before do
      Employee.stub!(:new).and_return(mock_employee(:save => true))
      PhoneNumber.stub!(:new).and_return(mock_phone_number)
      mock_phone_number.stub!(:<<).and_return([mock_phone_number])
      mock_employee.stub!(:phone_numbers).and_return([mock_phone_number])
      get :new
    end

    it { response.should be_success }

    it "should set @employee" do
      assigns[:employee].should equal(mock_employee)
    end

    it "should set @phone_numbers" do
      assigns[:phone_numbers].should include mock_phone_number
    end
  end



  describe "GET 'edit'" do
    before do
      Employee.stub!(:find).with(1).and_return(mock_employee)
      mock_employee.stub!(:phone_numbers).and_return([mock_phone_number])
      get :edit, :id => 1
    end

    it { response.should be_success }

    it "should set @employee" do
      assigns[:employee].should equal(mock_employee)
    end

    it "should set @phone_numbers" do
      assigns[:phone_numbers].should include mock_phone_number
    end
  end



  describe "PUT 'update'" do
    before do
      request.env["HTTP_REFERER"] = 
          edit_employee_path(mock_employee)
      Employee.stub!(:find).with(1).and_return(mock_employee)
      mock_employee.stub!(:phone_numbers).and_return([mock_phone_number])
    end

    describe "with valid attributes" do
      before do
        mock_employee.stub!(:update_attributes).and_return(true)
        put :update, :id => 1, :employee => mock_employee
      end

      it "should set a success message" do
        flash[:notice].should == "Employee updated successfully"
      end

      it { response.should redirect_to(edit_employee_path(mock_employee)) }

      it "should set @employee" do
        assigns[:employee].should equal(mock_employee)
      end

      it "should set @phone_numbers" do
        assigns[:phone_numbers].should include mock_phone_number
      end
    end

    describe "with invalid attributes" do
      before do
        mock_employee.should_receive(:update_attributes).and_return(false)
        put :update, :id => 1, :employee => mock_employee
      end

      it "should set an error message" do
        flash[:error].should == "Failed to update employee"
      end

      it { response.should render_template('edit') }
    end

  end



  describe "GET 'show'" do
    before do
      Employee.stub!(:find).with(1).and_return(mock_employee)
      get :show, :id => 1
    end

    it { response.should be_success }

    it "should set @employee" do
      assigns[:employee].should == mock_employee
    end
  end



  describe "POST 'create'" do
    before do
      Employee.stub!(:new).and_return(mock_employee(:save => true))
      mock_employee.stub!(:phone_numbers).and_return([mock_phone_number])
    end

    it "should set @phone_numbers" do
      post :create, :employee => mock_employee
      assigns[:phone_numbers].should include mock_phone_number
    end

    describe "with valid attributes" do
      before do
        mock_employee.stub!(:save).and_return(true)
        post :create, :employee => mock_employee
      end

      it "should create a new employee" do
        assigns[:employee].should equal(mock_employee)
      end
  
      it "should set a success message" do
        flash[:notice].should == "Employee added successfully"
      end
  
      it { response.should redirect_to employees_path }
    end
    
    describe "with invalid attributes" do
      before do
        mock_employee.stub!(:save).and_return(false)
        post :create, :employee => mock_employee
      end

      it "should set an error message" do
        flash.now[:error].should == "Failed to create employee"
      end

      it { response.should render_template(:new) }
    end

  end



  describe "GET 'index'" do
    before do
      Employee.stub!(:all).and_return([mock_employee])
      get :index
    end

    it { response.should be_success }

    it "should assign a list of employees to @employees" do
      assigns[:employees].should include mock_employee
    end

    it { response.should render_template(:index) }
  end



  def mock_employee(stubs={})
    @mock_employee ||= mock_model(Employee, stubs)
  end

  def mock_phone_number(stubs={})
    @mock_phone_Number ||= mock_model(PhoneNumber, stubs)
  end
end
