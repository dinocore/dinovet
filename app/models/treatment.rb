module Dinovet
  module Fields
    module Treatment
      extend ActiveSupport::Concern
      included do
        field :name
        field :code
        field :description

        validates_presence_of :name, :code
      end
    end
  end
end


class Treatment
  include Mongoid::Document
  include Mongoid::Timestamps
  include Dinovet::Fields::Treatment

  validates_uniqueness_of :name, :code

  references_and_referenced_in_many :categories,
                                    :class_name => 'TreatmentCategory',
                                    :inverse_of => :treatments
  alias :treatment_categories :categories
end
