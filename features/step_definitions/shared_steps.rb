Then /^I should see the (.*) form$/ do |name|
  name.gsub!(' ', '_')
  page.should have_css("form.#{name}")
end
