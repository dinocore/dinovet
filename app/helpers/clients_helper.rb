module ClientsHelper
  def name_last_first(client)
    header = client.last_name
    unless client.first_name.blank?
      header += ", #{client.first_name}"
    end
  end

  def client_panel(client, &block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'client',
        :title => "Client",
        :subtitle => name_last_first(client) }, 
      &block
  end

  def clients_panel(&block)
    render :layout => 'layouts/panel',
      :locals => { 
        :id => 'clients',
        :title => "Clients" },
      &block
  end

  def patient_select_list(client)
    patients = client.patients.map do |p|
      content_tag :li do
        link_to h(p.name), edit_patient_path(p), :remote => true
      end
    end

    content_tag :ul do
      patients.join.html_safe
    end
  end
end
