Given /^all models have been indexed$/ do
  [Client, Patient, Employee].each { |model| Sunspot.index!(model.all) }
end
