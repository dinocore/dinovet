Given /^I have created a treatment category(?: named "([^"]*)")?$/ do |name|
  @category = Factory.create(:treatment_category, :name => (name || 'Stuff'))
end
