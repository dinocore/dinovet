class TreatmentsController < ApplicationController
  def new
    @treatment = Treatment.new
    @categories = TreatmentCategory.list
  end

  def create
    @treatment = Treatment.new(params[:treatment])

    if @treatment.save
      flash[:notice] = "Treatment created successfully"

      #FIXME: This is a dirty hack to get around Mongoid's nested builder issues
      #<dirtyhack>
      params[:treatment][:category_ids].each do |id|
        category = TreatmentCategory.find(id)
        category.treatments << @treatment
        category.save
      end unless params[:treatment][:category_ids].nil?
      #</dirtyhack>

      respond_to do |format|
        format.js do
          @categories = TreatmentCategory.all
          render :success
        end
        format.html { redirect_to treatments_path }
      end
    else
      @categories = TreatmentCategory.list
      flash[:error] = "Failed to create treatment"
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end

  def index
    @treatments = Treatment.all
    @categories = TreatmentCategory.all
  end

  def edit
    @treatment = Treatment.find(params[:id])
    @categories = TreatmentCategory.list
  end

  def update
    @treatment = Treatment.find(params[:id])

    if @treatment.update_attributes(params[:treatment])

      #FIXME: This is a dirty hack to get around Mongoid's nested builder issues
      #<dirtyhack>
      TreatmentCategory.any_in(:treatment_ids => [@treatment.id]).each do |c|
        c.treatment_ids.delete_if { |d| d == @treatment.id }
        c.save
      end

      @treatment.categories.each do |c|
        c.treatment_ids << @treatment.id
        c.save
      end
      #</dirtyhack>

      flash[:notice] = "Treatment updated successfully"
      respond_to do |format|
        format.js do
          @categories = TreatmentCategory.all
          render :success
        end
        format.html { redirect_to treatments_path }
      end
    else
      @categories = TreatmentCategory.list
      flash[:error] = "Failed to update treatment"
      respond_to do |format|
        format.js
        format.html { render :edit }
      end
    end
  end
end
