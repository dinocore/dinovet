class Patient
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  validates_presence_of :name
  validates_presence_of :client

  referenced_in :client
end
