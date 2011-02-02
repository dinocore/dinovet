class Species
  include Mongoid::Document

  field :name

  embeds_many :breeds

  validates_presence_of :name

  def self.list
    all.collect { |s| s.name }
  end
end
