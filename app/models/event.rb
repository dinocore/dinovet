class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :patient, :inverse_of => :events
  
  def type
    _type.sub("Event", "")
  end

  attr_reader :name
end
