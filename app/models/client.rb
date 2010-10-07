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

  validates_presence_of :first_name, :last_name, :address_1, :city, :state,
                        :zipcode, :phone
  validates_format_of :email, :allow_nil => true,
                      :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i

  def self.search(query)
    any_of({ :first_name => query },
           { :last_name  => query },
           { :phone      => query },
           { :address_1  => query },
           { :email      => query })
  end
end
