class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :description

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.list
    all.collect { |c| [c.name, c.id] }
  end
end
