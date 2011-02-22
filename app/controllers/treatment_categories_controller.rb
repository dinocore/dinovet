class TreatmentCategoriesController < ApplicationController
  def new
    @treatment_category = TreatmentCategory.new
  end

  def create
    @treatment_category = TreatmentCategory.new(params[:treatment_category])
    if @treatment_category.save
      flash[:notice] = "Category created successfully"
      respond_to do |format|
        format.js do
          @categories = TreatmentCategory.all
          render 'success'
        end
        format.html { redirect_to treatments_path }
      end
    else
      @categories = TreatmentCategory.list
      flash[:error] = "Failed to create category"
      respond_to do |format|
        format.js do
          @categories = TreatmentCategory.all
        end
        format.html { render :new }
      end
    end
  end

  def edit
    @treatment_category = TreatmentCategory.find(params[:id])
  end

  def update
    @treatment_category = TreatmentCategory.find(params[:id])

    if @treatment_category.update_attributes(params[:treatment_category])
      flash[:notice] = "Category updated successfully"
      respond_to do |format|
        format.js do
          @categories = TreatmentCategory.all
          render 'success'
        end
        format.html { redirect_to treatments_path }
      end
    else
      flash[:error] = "Failed to update category"
      respond_to do |format|
        format.js do
          @categories = TreatmentCategory.all
        end
        format.html { render :edit }
      end
    end
  end
end
