module Mongoid
  module DiagnosisFields
    extend ActiveSupport::Concern
    included do
      field :name
      field :code
      field :description
  
      validates_presence_of :name, :code
      validates_uniqueness_of :name, :code
    end
  end
end


class Diagnosis
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::DiagnosisFields

  references_many :categories, 
                  :class_name => 'DiagnosisCategory',
                  :stored_as  => :array, 
                  :inverse_of => :diagnoses
  alias :diagnosis_categories :categories
end
