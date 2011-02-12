Given /^all models have been indexed$/ do
  [Client, Patient].each { |model| Sunspot.index!(model.all) }
end
