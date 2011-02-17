class Employee
  include Mongoid::Document
  include Mongoid::Timestamps
  include Sunspot::Mongoid
  field :first_name
  field :last_name
  field :title
  field :address_1
  field :address_2
  field :city
  field :state
  field :zipcode
  field :email

  embeds_many :phone_numbers

  accepts_nested_attributes_for :phone_numbers, :allow_destroy => true

  validates_associated :phone_numbers
  validates_presence_of :first_name, :last_name, :title, :address_1, :city,
                        :state, :zipcode, :phone_numbers
                        
  validates_format_of :email, :allow_nil => true,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  searchable do
    text   :first_name
    text   :last_name
    text   :title
    text   :address_1
    text   :city
    text   :state
    text   :zipcode
    text   :email
    text   :phone_numbers do |employee|
      employee.phone_numbers.map { |phone_number| phone_number.number }
    end
  end

  def full_name
    "#{last_name}, #{first_name}"
  end
end
