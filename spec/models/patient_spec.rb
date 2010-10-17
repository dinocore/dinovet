require 'spec_helper'

describe Patient do
  it { should validate_presence_of(:name) }
end
