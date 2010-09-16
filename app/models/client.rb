class Client
  include Mongoid::Document
  field :first_name
  field :last_name
  field :address_1
  field :address_2
  field :city
  field :state
  field :zipcode
  field :phone
  field :email
end
