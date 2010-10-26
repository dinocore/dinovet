class DiagnosesController < ApplicationController
  def new
    @diagnosis = Diagnosis.new
  end

  def create
    @diagnosis = Diagnosis.new(params[:diagnosis])
    if @diagnosis.save
      redirect_to diagnoses_path, :notice => "Diagnosis created successfully"
    else
      flash[:error] = "Failed to create diagnosis"
      render :new
    end
  end

  def index
    @diagnoses = Diagnosis.all
    @categories = DiagnosisCategory.all
  end

  def edit
    @diagnosis = Diagnosis.find(params[:id])
  end

  def update
    @diagnosis = Diagnosis.find(params[:id])

    if @diagnosis.update_attributes(params[:diagnosis])
      redirect_to diagnoses_path, :notice => "Diagnosis updated successfully"
    else
      flash[:error] = "Failed to update diagnosis"
      render :edit
    end
  end
end
