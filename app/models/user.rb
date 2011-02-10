class User
  include Mongoid::Document
  
  embedded_in :employee, :inverse_of => :user

  devise  :database_authenticatable, :lockable, :rememberable, 
          :registerable, :trackable

  field :name
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false
  attr_accessible :name, :email, :password, :password_confirmation

  timestamps!
end
