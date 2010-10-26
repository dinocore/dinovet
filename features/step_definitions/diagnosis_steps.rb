Given /^I have created a diagnosis$/ do
  @diagnosis = Factory.create(:diagnosis)
  @categories = DiagnosisCategories.all
end

Then /^I should see a list of diagnoses$/ do
  page.should have_css('ul') do |li|
    @categories.each do |category|
      li.should contain(category.name)
      li.should have_css('ul') do |ul_li|
        category.diagnoses do |diagnosis|
          ul_li.should contain(diagnosis.name)
        end
      end
    end
  end
end
