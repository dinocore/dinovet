Given /^I am an employee$/ do
end

Given /^I have added a client(?: named "([^"]*)")?$/ do |name|
  attributes = name.blank? ? {} : {:first_name => name}
  @client = Factory.create(:client, attributes)
end

Given /^I have added an additional client phone number$/ do
  @client.phone_numbers << Factory.create(:phone_number)
end

And /^I am editing the client$/ do
  visit edit_client_path(@client)
end

When /^I delete the (\d+)(?:st|nd|rd|th) client$/ do |pos|
  visit clients_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end
