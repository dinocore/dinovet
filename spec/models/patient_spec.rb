require 'spec_helper'

describe Patient do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:sex) }
  it { should validate_presence_of(:client) }
  it { should validate_numericality_of(:weight) }
  it { should be_referenced_in(:client) }
  it { should embed_many(:events) }
end
