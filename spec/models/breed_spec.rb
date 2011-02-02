require 'spec_helper'

describe Breed do
  it { should have_field(:name) }
  it { should validate_presence_of(:name) }
  it { should be_embedded_in(:species) }

  describe ".list" do
    before do
      @species = create_species
      @breeds = @species.breeds.collect { |b| b.name } 
    end

    it "should return a list of species names" do
      Breed.list(@species.name).should == @breeds
    end
  end
end

def create_species(parameters = {})
  Factory.create(:species, parameters)
end

def create_breed(parameters = {})
  Factory.create(:species, parameters)
end
