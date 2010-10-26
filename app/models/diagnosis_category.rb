class DiagnosisCategory < Category
  references_many :diagnoses, :stored_as  => :array, :inverse_of => :categories
end
