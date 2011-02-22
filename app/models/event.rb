class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :patient, :inverse_of => :events
  
  attr_reader :name

  named_scope :diagnoses,       :any_in => { :_type => "DiagnosisEvent" }
  named_scope :treatments,      :any_in => { :_type => "TreatmentEvent" }
  named_scope :created_between, lambda { |start = nil, finish = nil|
    unless start.nil?
      finish = start if finish.nil?
      where(:created_at.gte => start, :created_at.lte => finish.end_of_day)
    else
      all
    end
  }

  FILTERS = { 
    ''           => { :scope => :all,         :label => 'Show All'   },
    'diagnoses'  => { :scope => :diagnoses,   :label => 'Diagnoses'  },
    'treatments' => { :scope => :treatments,  :label => 'Treatments' }
  }
end
