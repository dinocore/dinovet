class Diagnosis
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :code
  field :description

  validates_presence_of :name, :code
  validates_uniqueness_of :name, :code

  references_many :categories, 
                  :class_name => 'DiagnosisCategory',
                  :stored_as  => :array, 
                  :inverse_of => :diagnoses
  alias :diagnosis_categories :categories
end
