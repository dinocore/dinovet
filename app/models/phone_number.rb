class PhoneNumber
  include Mongoid::Document
  Types = ['Home', 'Cell']
  field :type
  field :number

  embedded_in :client, :inverse_of => :phone_numbers

  validates_presence_of :number, :type
end
