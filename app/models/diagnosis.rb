module Mongoid
  module DiagnosisFields
    extend ActiveSupport::Concern
    included do
      field :name
      field :code
      field :description

      validates_presence_of :name, :code
    end
  end
end


class Diagnosis
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::DiagnosisFields

  validates_uniqueness_of :name, :code

  references_and_referenced_in_many :categories,
                                    :class_name => 'DiagnosisCategory',
                                    :inverse_of => :diagnoses
  alias :diagnosis_categories :categories
end
