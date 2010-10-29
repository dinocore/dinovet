class Patient
  include Mongoid::Document
  include Mongoid::Timestamps
  Sexes = ['Male', 'Female']
  Species = ['Canine', 'Feline']
  Breed = ['Yorkshire Terrier', 'Lab', 'Poodle']

  field :name
  field :sex
  field :species
  field :breed
  field :weight
  field :birth_date, :type => Date
  field :color
  field :microchip

  embeds_many :events
  referenced_in :client

  validates_presence_of :client
  validates_presence_of :name, :sex, :species, :breed
end
