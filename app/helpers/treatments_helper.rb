module TreatmentsHelper
  def treatment_panel(treatment, &block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'treatment',
        :title => "Treatment",
        :subtitle => treatment.name }, 
      &block
  end

  def treatments_panel(&block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'treatments',
        :title => "Treatments" },
      &block
  end

  def create_treatment_link
    link_to image_tag('add.png') + "Create a new treatment", 
        new_treatment_path, :remote => true
  end

  def edit_treatment_link(treatment)
    link_to h(treatment.name), edit_treatment_path(treatment), :remote => true
  end

  def update_treatments_list(categories)
    "$('#treatments ul.treatments').replaceWith('#{ 
       escape_javascript(render "treatments/treatments_list")}');".html_safe
  end
end
