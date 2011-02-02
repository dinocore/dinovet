Given /^I have added a client and patient/ do
  @client = Factory.create(:client)
  @client.patients << Factory.create(:patient, :client => @client)
  @patient = @client.patients.first
end

When /^I select the patient from the patients list$/ do
  click_link(@patient.name)
end

Given /^I have added a species and breed$/ do
  @breed = Factory.create(:breed, :name => "Yorkshire Terrier")
  @species = Factory.create(:species, :name => "Dog", :breeds => [@breed])
end
