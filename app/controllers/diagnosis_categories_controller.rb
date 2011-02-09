class DiagnosisCategoriesController < ApplicationController
  def new
    @diagnosis_category = DiagnosisCategory.new
  end

  def create
    @diagnosis_category = DiagnosisCategory.new(params[:diagnosis_category])
    if @diagnosis_category.save
      flash[:notice] = "Category created successfully"
      respond_to do |format|
        format.js do
          @categories = DiagnosisCategory.all
          render 'success'
        end
        format.html { redirect_to diagnoses_path }
      end
    else
      @categories = DiagnosisCategory.list
      flash[:error] = "Failed to create category"
      respond_to do |format|
        format.js do
          @categories = DiagnosisCategory.all
        end
        format.html { render :new }
      end
    end
  end

  def edit
    @diagnosis_category = DiagnosisCategory.find(params[:id])
  end

  def update
    @diagnosis_category = DiagnosisCategory.find(params[:id])

    if @diagnosis_category.update_attributes(params[:diagnosis_category])
      flash[:notice] = "Category updated successfully"
      respond_to do |format|
        format.js do
          @categories = DiagnosisCategory.all
          render 'success'
        end
        format.html { redirect_to diagnoses_path }
      end
    else
      flash[:error] = "Failed to update category"
      respond_to do |format|
        format.js do
          @categories = DiagnosisCategory.all
        end
        format.html { render :edit }
      end
    end
  end
end
