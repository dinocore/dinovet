class Client
  include Mongoid::Document
  field :first_name
  field :last_name
  field :address_1
  field :address_2
  field :city
  field :state
  field :zipcode
  field :email

  embeds_many :phone_numbers

  accepts_nested_attributes_for :phone_numbers

  validates_associated :phone_numbers
  validates_presence_of :first_name, :last_name, :address_1, :city, :state,
                        :zipcode, :phone_numbers
  validates_format_of :email, :allow_nil => true,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  def self.search(query)
    
    if query.blank?
      return find :all
    end

    any_of({ :first_name             => /.*#{query}.*/ },
           { :last_name              => /.*#{query}.*/ },
           { :address_1              => /.*#{query}.*/ },
           { :email                  => /.*#{query}.*/ },
           { "phone_numbers.number"  => /.*#{query}.*/ })
  end
end
