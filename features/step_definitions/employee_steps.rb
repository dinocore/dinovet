Given /^I have added a employee$/ do
  @employee = Factory.create(:employee)
end

Given /^I have added a employee named "(.*)"$/ do |name|
  @employee = Factory.create(:employee, {:first_name => name})
end

And /^I am editing the employee$/ do
  visit edit_employee_path(@employee)
end

When /^I delete the (\d+)(?:st|nd|rd|th) employee$/ do |pos|
  visit employees_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end
