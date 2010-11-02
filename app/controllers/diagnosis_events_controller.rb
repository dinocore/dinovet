class DiagnosisEventsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @diagnosis_categories = DiagnosisCategory.all
    @diagnosis_event = DiagnosisEvent.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @diagnosis = Diagnosis.find(params[:diagnosis_id])
    @diagnosis_event = DiagnosisEvent.new(params[:diagnosis_event])
    @diagnosis_event.attributes = {
        :name        => @diagnosis.name,
        :code        => @diagnosis.code,
        :description => @diagnosis.description
    }

    @patient.events << @diagnosis_event

    if @diagnosis_event.save
      redirect_to patient_events_path(@patient),
        :notice => "Diagnosis recorded"
    else
      flash[:error] = "Failed to make diagnosis"
      @diagnosis_categories = DiagnosisCategory.all
      render :new
    end
  end
end
