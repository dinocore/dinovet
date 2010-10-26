# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Dinovet::Application.initialize!

ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular('diagnosis', 'diagnosis')
  inflect.singular('diagnosis_categories', 'diagnosis_category')
end
