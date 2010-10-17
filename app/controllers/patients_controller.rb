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

    if @patient.save
      redirect_to client_patients_path(@client),
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
end
