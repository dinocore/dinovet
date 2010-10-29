class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :patient, :inverse_of => :events
  
  attr_reader :name
end
