module PatientsHelper
  def patient_panel(patient, &block)
    links = { :Details => 'http://www.google.com' }
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'patient',
        :title => "Patient",
        :subtitle => patient.name,
        :links => links }, 
      &block
  end
end
