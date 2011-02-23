Given /^I have added a client(?: named "([^"]*)")? and patient(?: named "([^"]*)")?$/ do |client, patient|
  attributes = client.blank? ? {} : {:first_name => client}
  @client = Factory.create(:client, attributes)
  attributes = patient.blank? ? {} : {:name => patient}
  @client.patients << Factory.create(:patient,
                                      attributes.merge(:client => @client))
  @patient = @client.patients.first
end

Given /^I have added a patient(?: named "([^"]*)")?$/ do |name|
  @client.patients << Factory.create(:patient, :name => name,:client => @client)
  @patient = @client.patients.first
end

When /^I select the patient from the patients list$/ do
  click_link(@patient.name)
end

Given /^I have added a species and breed$/ do
  @breed = Factory.create(:breed, :name => "Yorkshire Terrier")
  @species = Factory.create(:species, :name => "Dog", :breeds => [@breed])
  cat_breed = Factory.create(:breed, :name => "American Longhair")
  cat_species = Factory.create(:species, :name => "Cat", :breeds => [cat_breed])
end
