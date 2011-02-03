require 'spec_helper'

describe SpeciesController do
  before do
    Species.stub!(:find).and_return(mock_species)
    mock_species.stub!(:name).and_return("Dog")
  end


  describe "GET 'show'" do
    before { get :show, :id => mock_species.name, :format => 'json' }

    it { response.should be_success }
  end

end

def mock_species(stubs={})
  @mock_species ||= mock_model(Species, stubs)
end
