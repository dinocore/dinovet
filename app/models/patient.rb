class Patient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  validates_presence_of :name
end
