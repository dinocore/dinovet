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
    @species = Species.list
    @breeds  = Breed.list(@patient.species)

    if @patient.save
      flash[:notice] = "Patient created successfully"
      respond_to do |format|
        format.js   { render :success }
        format.html { redirect_to edit_patient_path(@patient) }
      end
    else
      flash[:error] = "Failed to create patient"
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end

  def edit
    @patient = Patient.find(params[:id])
    @species = Species.list
    @breeds  = Breed.list(@patient.species)
  end

  def update
    @patient = Patient.find(params[:id])
    @species = Species.list
    @breeds  = Breed.list(@patient.species)

    if @patient.update_attributes(params[:patient])
      flash[:notice] = "Patient updated successfully"
      respond_to do |format|
        format.js   { redirect_to edit_patient_path(@patient, :format => :js) }
        format.html { redirect_to edit_patient_path(@patient) }
      end
    else
      flash[:error] = "Failed to update patient"
      respond_to do |format|
        format.js
        format.html { render :edit }
      end
    end
  end
end
