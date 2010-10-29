class DiagnosisEvent < Event
  field :name
  field :code
  field :description
  validates_presence_of :name, :code
end
