Given /^I have added an employee(?: named "([^"]*)")?$/ do |name|
  attributes = name.blank? ? {} : {:first_name => name}
  @employee = Factory.create(:employee, attributes)
end

And /^I am editing the employee$/ do
  visit edit_employee_path(@employee)
end

Given /^I have added an additional employee phone number$/ do
  @employee.phone_numbers << Factory.create(:phone_number)
end

When /^I delete the (\d+)(?:st|nd|rd|th) employee$/ do |pos|
  visit employees_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end
