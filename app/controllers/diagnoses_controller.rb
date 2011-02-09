class DiagnosesController < ApplicationController
  def new
    @diagnosis = Diagnosis.new
    @categories = DiagnosisCategory.list
  end

  def create
    @diagnosis = Diagnosis.new(params[:diagnosis])

    if @diagnosis.save
      flash[:notice] = "Diagnosis created successfully"

      #FIXME: This is a dirty hack to get around Mongoid's nested builder issues
      #<dirtyhack>
      params[:diagnosis][:category_ids].each do |id|
        category = DiagnosisCategory.find(id)
        category.diagnoses << @diagnosis
        category.save
      end unless params[:diagnosis][:category_ids].nil?
      #</dirtyhack>

      respond_to do |format|
        format.js do
          @categories = DiagnosisCategory.all
          render :success
        end
        format.html { redirect_to diagnoses_path }
      end
    else
      @categories = DiagnosisCategory.list
      flash[:error] = "Failed to create diagnosis"
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end

  def index
    @diagnoses = Diagnosis.all
    @categories = DiagnosisCategory.all
  end

  def edit
    @diagnosis = Diagnosis.find(params[:id])
    @categories = DiagnosisCategory.list
  end

  def update
    @diagnosis = Diagnosis.find(params[:id])

    if @diagnosis.update_attributes(params[:diagnosis])

      #FIXME: This is a dirty hack to get around Mongoid's nested builder issues
      #<dirtyhack>
      DiagnosisCategory.any_in(:diagnosis_ids => [@diagnosis.id]).each do |c|
        c.diagnosis_ids.delete_if { |d| d == @diagnosis.id }
        c.save
      end

      @diagnosis.categories.each do |c|
        c.diagnosis_ids << @diagnosis.id
        c.save
      end
      #</dirtyhack>

      flash[:notice] = "Diagnosis updated successfully"
      respond_to do |format|
        format.js do
          @categories = DiagnosisCategory.all
          render :success
        end
        format.html { redirect_to diagnoses_path }
      end
    else
      @categories = DiagnosisCategory.list
      flash[:error] = "Failed to update diagnosis"
      respond_to do |format|
        format.js
        format.html { render :edit }
      end
    end
  end
end
