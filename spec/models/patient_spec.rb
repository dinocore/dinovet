require 'spec_helper'

describe Patient do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:client) }

  it { should be_referenced_in(:client) }

end