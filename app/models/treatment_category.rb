class TreatmentCategory < Category
  references_and_referenced_in_many :treatments, :inverse_of => :categories
end
