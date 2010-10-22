class Diagnosis
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :code
  field :description

  validates_presence_of :name, :code
  validates_uniqueness_of :name, :code

end
