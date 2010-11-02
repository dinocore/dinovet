# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format
# (all these examples are active by default):
# ActiveSupport::Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end
ActiveSupport::Inflector.inflections do |inflect|
  inflect.singular('diagnosis', 'diagnosis')
  inflect.singular('diagnosis_categories', 'diagnosis_category')
  inflect.singular('diagnosis_events', 'diagnosis_event')
  inflect.singular('patient_diagnosis_events', 'patient_diagnosis_event')
end
