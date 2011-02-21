class TreatmentPlansController < ApplicationController
  def new
    @patient = Patient.find(params[:patient_id])
    #@treatment_categories = TreatmentCategory.all
    @treatment_plan = TreatmentPlan.new
  end

  def create
    @patient = Patient.find(params[:patient_id])
    @treatment_plan = TreatmentPlan.new(params[:treatment_plan])

    if @treatment_plan.save
      flash[:notice] = "Treatment plan created successfully"
      respond_to do |format|
        format.js do
          redirect_to patient_treatment_plans_path(@patient, :format=>:js)
        end
        format.html { redirect_to patient_treatment_plans_path(@patient) }
      end
    else
      #@treatment_categories = TreatmentCategory.all
      flash[:error] = "Failed to create treatment plan"
      respond_to do |format|
        format.js
        format.html { render :new }
      end
    end
  end
end
