class DiagnosisEvent < Event
  include Mongoid::DiagnosisFields
  field :comment

  attr_accessor :diagnosis_id

  validates_presence_of :diagnosis_id
  before_validation :copy_diagnosis

  protected
  def copy_diagnosis
    unless diagnosis_id.blank?
      diagnosis = Diagnosis.find(diagnosis_id)
      self.name = diagnosis.name
      self.code = diagnosis.code
      self.description = diagnosis.description
    end
  end
end
