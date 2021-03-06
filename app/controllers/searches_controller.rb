class SearchesController < ApplicationController
  def show
    unless params[:q].blank?
      @results = Sunspot.search(Client, Patient, Employee) {
          keywords params[:q]
        }.results
    else
      @results = []
    end
  end
end
