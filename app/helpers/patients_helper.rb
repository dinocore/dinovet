module PatientsHelper
  def patient_select_list(client, patient = nil)

    patient_list = ""
    client.patients.each do |patient|
      patient_list +=<<-HTML
        <li>
          #{link_to h(patient.name), edit_client_patient_path(client, patient)}
        </li>
      HTML
    end
    patient_list +=<<-HTML
      <li>
        &raquo; 
          #{link_to "Create a New Patient", new_client_patient_path(client)}
      </li>
    HTML

    if patient.nil?
      content = "Select a Patient"
    else
      content = patient.new_record? ? "&raquo; New Patient" : patient.name
    end

    out =<<-HTML
      <div id='patient-select'>
        <h3>#{content}</h3>
        <ul>
          #{patient_list}
        </ul>
      </div>
    HTML

  end

end
