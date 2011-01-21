class DiagnosisCategory < Category
  references_and_referenced_in_many :diagnoses, :inverse_of => :categories
end
