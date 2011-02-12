namespace :sunspot do
  desc "indexes searchable models"
  task :index => :environment do
    [Client, Patient].each { |model| Sunspot.index!(model.all) }
  end
end
