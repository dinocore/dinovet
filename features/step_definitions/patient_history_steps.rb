Given /^I have made a diagnosis$/ do
  @patient.events << @event = Factory.build(:diagnosis_event)
  @event.save
end

Then /^I should see a list of events$/ do
  page.should have_css('table') do |table|
    @patient.events.each do |event|
      table.should have_css('tr') do |row|
        table.should have_css('td') do |col|
          col.should contain(event._type)
        end
      end
    end
  end
end
