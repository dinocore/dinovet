require 'spec_helper'

describe Species do
  it { should have_field(:name) }
  it { should validate_presence_of(:name) }
  it { should embed_many(:breeds) }

  describe ".list" do
    before { @species = 5.times.collect { create_species.name } }

    it "should return a list of species names" do
      Species.list.should == @species
    end
  end
end

def create_species(parameters = {})
  Factory.create(:species, parameters)
end
