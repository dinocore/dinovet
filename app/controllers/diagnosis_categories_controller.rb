class DiagnosisCategoriesController < ApplicationController
  def new
    @diagnosis_category = DiagnosisCategory.new
  end

  def create
    @diagnosis_category = DiagnosisCategory.new(params[:diagnosis_category])
    if @diagnosis_category.save
      redirect_to diagnoses_path, 
        :notice => "Category created successfully"
    else
      flash[:error] = "Failed to create category"
      render :new
    end
  end

  def edit
    @diagnosis_category = DiagnosisCategory.find(params[:id])
  end

  def update
    @diagnosis_category = DiagnosisCategory.find(params[:id])

    if @diagnosis_category.update_attributes(params[:diagnosis_category])
      redirect_to diagnoses_path, :notice => "Category updated successfully"
    else
      flash[:error] = "Failed to update category"
      render :edit
    end
  end
end
