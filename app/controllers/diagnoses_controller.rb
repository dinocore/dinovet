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
  end
end
