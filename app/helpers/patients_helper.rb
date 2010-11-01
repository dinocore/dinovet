module PatientsHelper
  def patient_panel(patient, &block)
    links = { 
      :Details => edit_patient_path(patient),
      :History => patient_events_path(patient)
    } unless patient.new_record?

    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'patient',
        :title => "Patient",
        :subtitle => patient.name,
        :links => links }, 
      &block
  end
end
