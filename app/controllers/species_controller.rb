class SpeciesController < ApplicationController

  respond_to :json

  def show
    respond_with(Species.find(:first, :conditions => { :name => params[:id] }))
  end

end
