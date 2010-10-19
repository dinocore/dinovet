class PatientsController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers
    @patient = Patient.new
  end

  def create
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers

    @patient = Patient.new(params[:patient])
    @patient.client = @client

    if @patient.save
      redirect_to edit_client_patient_path(@client, @patient),
          :notice => "Patient created successfully"
    else
      flash[:error] = "Failed to create patient"
      render :new
    end
  end

  def index
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers
    @patients = Patient.all
  end

  def edit
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers
    @patient = Patient.find(params[:id])
  end

  def update
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers
    @patient = Patient.find(params[:id])

    if @patient.update_attributes(params[:patient])
      redirect_to :back,
          :notice => "Patient updated successfully"
    else
      flash[:error] = "Failed to update patient"
      render :edit
    end
  end

  def show
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers
    @patient = Patient.find(params[:id])
  end
end
