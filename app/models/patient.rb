class Patient
  include Mongoid::Document
  include Mongoid::Timestamps
  Sexes  = ['Male',  'Female']

  field :name
  field :sex
  field :species
  field :breed
  field :weight, :type => Float, :default => 0.0
  field :birth_date, :type => Date
  field :color
  field :microchip

  embeds_many :events
  referenced_in :client

  validates_presence_of :client
  validates_presence_of :name, :sex, :species, :breed
  validates_numericality_of :weight, :greater_than_or_equal_to => 0
end
