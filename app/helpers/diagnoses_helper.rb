module DiagnosesHelper
  def diagnosis_panel(diagnosis, &block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'diagnosis',
        :title => "Diagnosis",
        :subtitle => diagnosis.name }, 
      &block
  end

  def diagnoses_panel(&block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'diagnoses',
        :title => "Diagnoses" },
      &block
  end

  def create_diagnosis_link
    link_to image_tag('add.png') + "Create a new diagnosis", 
        new_diagnosis_path, :remote => true
  end

  def edit_diagnosis_link(diagnosis)
    link_to h(diagnosis.name), edit_diagnosis_path(diagnosis), :remote => true
  end

  def update_diagnoses_list(categories)
    "$('#diagnoses ul.diagnoses').replaceWith('#{ 
       escape_javascript(render "diagnoses/diagnoses_list")}');".html_safe
  end
end
