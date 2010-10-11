class PhoneNumber
  include Mongoid::Document
  Types = ['Home', 'Cell']
  field :type
  field :country_code
  field :area_code
  field :prefix
  field :suffix
  field :extension

  embedded_in :client, :inverse_of => :phone_numbers

  validates_presence_of :area_code, :prefix, :suffix, :type
  validates_format_of :area_code, :prefix, :with => /\d{3}/
  validates_format_of :suffix, :with => /\d{4}/
  validates_numericality_of :country_code, :extension, :only_integer => true

  def self.from_string(string)
    # Build a PhoneNumber object based on a string of format ###-###-####
    number = string.split(/-/)
    new :area_code => number[0],
        :prefix    => number[1],
        :suffix    => number[2]
  end

  def to_s
    string = "#{country_code}#{area_code}#{prefix}#{suffix}"
    string += "x#{extension}" unless extension.blank?
  end
end
