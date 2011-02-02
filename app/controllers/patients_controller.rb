class PatientsController < ApplicationController
  def new
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers
    @patient = Patient.new
    @species = Species.list
    @breeds  = Breed.list(@species.first)
  end

  def create
    @client = Client.find(params[:client_id])
    @phone_numbers = @client.phone_numbers

    @patient = Patient.new(params[:patient])
    @patient.client = @client

    if @patient.save
      redirect_to edit_patient_path(@patient),
          :notice => "Patient created successfully"
    else
      @species = Species.list
      @breeds  = Breed.list(@patient.species)
      flash[:error] = "Failed to create patient"
      render :new
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    @species = Species.list
    @breeds  = Breed.list(@patient.species)
  end

  def update
    @patient = Patient.find(params[:id])

    if @patient.update_attributes(params[:patient])
      redirect_to :back,
          :notice => "Patient updated successfully"
    else
      @species = Species.list
      @breeds  = Breed.list(@patient.species)
      flash[:error] = "Failed to update patient"
      render :edit
    end
  end
end
