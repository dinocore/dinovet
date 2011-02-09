Given /^I have created a diagnosis category(?: named "([^"]*)")?$/ do |name|
  @category = Factory.create(:diagnosis_category, :name => (name || 'Diseases'))
end
