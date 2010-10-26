class Category
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name
  field :description

  validates_presence_of :name
  validates_uniqueness_of :name
end
