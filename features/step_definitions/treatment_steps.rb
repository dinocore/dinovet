Given /^I have created a treatment(?: named "([^"]*)")?$/ do |name|
  @treatment = Factory.create(:treatment, :name => (name || 'Surgery'))
  @category = Factory.create(:treatment_category)
  @category.treatments << @treatment
  @treatment.save!
end

Then /^I should see a list of treatments$/ do
  page.should have_css('ul') do |li|
    @categories.each do |category|
      li.should contain(category.name)
      li.should have_css('ul') do |ul_li|
        category.treatments do |treatment|
          ul_li.should contain(treatment.name)
        end
      end
    end
  end
end
