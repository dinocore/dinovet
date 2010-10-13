module ClientsHelper
  def name_last_first(client)
    header = client.last_name
    unless client.first_name.blank?
      header += ", #{client.first_name}"
    end
  end
end
