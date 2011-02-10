class PhoneNumber
  include Mongoid::Document
  include Mongoid::Timestamps
  Types = ['Home', 'Cell']
  field :label
  field :number

  embedded_in :client, :inverse_of => :phone_numbers

  validates_presence_of :number, :label
end
