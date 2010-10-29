class EventsController < ApplicationController
  def index
    @patient = Patient.find(params[:patient_id])
    @events = @patient.events
  end
end
