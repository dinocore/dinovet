class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
    @employee = Employee.new
    @phone_numbers = @employee.phone_numbers << PhoneNumber.new
  end

  def edit
    @employee = Employee.find(params[:id])
    @phone_numbers = @employee.phone_numbers
  end

  def update
    @employee = Employee.find(params[:id])
    @phone_numbers = @employee.phone_numbers

    if @employee.update_attributes(params[:employee])
      redirect_to :back, :notice => "Employee updated successfully"
    else
      flash[:error] = "Failed to update employee"
      render "edit"
    end
  end

  def create
    @employee = Employee.new(params[:employee])
    @phone_numbers = @employee.phone_numbers

    if @employee.save
      redirect_to employees_path, :notice => "Employee added successfully"
    else
      flash[:error] = "Failed to create employee"
      render :new
    end
  end

end
