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

Given /^I am not authenticated$/ do
  visit('/users/sign_out') # ensure that at least
end

Given /^I have one\s+user "([^\"]*)" with password "([^\"]*)" and login "([^\"]*)"$/ do |email, password, login|
  User.new(:email => email,
           :login => login,
           :password => password,
           :password_confirmation => password).save!
end

Given /^I am a new, authenticated user$/ do
  email = 'testing@man.net'
  login = 'Testing man'
  password = 'secretpass'

  Given %{I have one user "#{email}" with password "#{password}" and login "#{login}"}
  And %{I go to login}
  And %{I fill in "user_email" with "#{email}"}
  And %{I fill in "user_password" with "#{password}"}
  And %{I press "Sign in"}
end
