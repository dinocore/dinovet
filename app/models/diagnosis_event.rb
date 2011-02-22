class DiagnosisEvent < Event
  include Dinovet::Fields::Diagnosis
  field :comment

  attr_accessor :diagnosis_id

  before_validation     :copy_diagnosis, :on => :create
  validates_presence_of :diagnosis_id,   :on => :create

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
