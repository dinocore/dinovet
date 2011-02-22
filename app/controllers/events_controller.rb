class EventsController < ApplicationController
  before_filter :get_filter, :get_date_filter

  def index
    @patient = Patient.find(params[:patient_id])
    @events = @patient.events.created_between(*@date_filter).send(@filter)
  end

  protected
  def get_filter
    filter_pair = Event::FILTERS[params[:filter]]
    unless filter_pair.nil?
      @filter = filter_pair[:scope]
    else
      @filter = :all
    end
  end

  def get_date_filter
    unless params[:date_filter].blank?
      @date_filter = params[:date_filter].split('-')[0..1].map { |d| d.strip }
      @date_filter.map! { |d| Time.strptime(d, "%m/%d/%Y") }
    end
  end
end
