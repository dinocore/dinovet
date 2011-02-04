module PatientsHelper
  def patient_panel(patient, tab=nil, &block)
    links = { 
      :Details => edit_patient_path(patient),
      :History => patient_events_path(patient),
      :Diagnose => new_patient_diagnosis_event_path(patient)
    } unless patient.new_record?

    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'patient',
        :title => "Patient",
        :subtitle => patient.name,
        :links => links,
        :tab => tab }, 
      &block
  end

  def birthday_select(form)
    form.date_select :birth_date, {
                        :start_year => 1900,
                        :end_year => Time.now.year,
                        :use_short_month => true
                     }, {:class => 'date'}
  end

  def update_patient_list(client)
    "$('fieldset.patients ul').replaceWith('#{patient_select_list(@patient.client)}');".html_safe
  end
end
