Given /^I have added a client and patient/ do
  @client = Factory.create(:client)
  @patient = @client.patients.first
end

When /^I select the patient from the patients list$/ do
  click_link(@patient.name)
end
