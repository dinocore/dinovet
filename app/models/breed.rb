class Breed
  include Mongoid::Document

  field :name

  embedded_in :species, :inverse_of => :breeds

  validates_presence_of :name

  def self.list(species)
    species = Species.where(:name => species, :breeds.exists => true).first
    unless species.nil?
      species.breeds.collect { |b| b.name }
    else
      []
    end
  end
end
