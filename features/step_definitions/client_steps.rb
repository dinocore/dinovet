Given /^I am an employee$/ do
end

Given /^I have added a client named "(.*)"$/ do |name|
  @client = Factory.create(:client, {:first_name => name})
end

And /^I am editing the client$/ do
  visit edit_client_path(@client)
end

Given /^the following clients:$/ do |clients|
  clients.hashes.each do |client|
    Client.create!(Factory.attributes_for(:client).merge(client))
  end
end

When /^I delete the (\d+)(?:st|nd|rd|th) client$/ do |pos|
  visit clients_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following clients:$/ do |expected_clients_table|
  expected_clients_table.diff!(tableish('table tr', 'td,th'))
end
