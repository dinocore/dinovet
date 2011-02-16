class DiagnosisEventsController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    @categories = DiagnosisCategory.all
    @diagnosis_event = DiagnosisEvent.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @diagnosis_event = DiagnosisEvent.new(params[:diagnosis_event])
    @patient.events << @diagnosis_event

    if @diagnosis_event.save
      flash[:notice] = "Diagnosis recorded"
      respond_to do |format|
        format.js   { redirect_to patient_events_path(@patient, :format=>:js) }
        format.html { redirect_to patient_events_path(@patient) }
      end
    else
      @categories = DiagnosisCategory.all
      flash[:error] = "Failed to make diagnosis"
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end
end
