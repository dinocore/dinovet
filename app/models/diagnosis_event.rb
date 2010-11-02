class DiagnosisEvent < Event
  include Mongoid::DiagnosisFields
  field :comment
  validates_presence_of :name, :code
end
