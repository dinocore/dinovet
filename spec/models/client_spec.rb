require 'spec_helper'

describe Client do

  it "creates a new client given valid input" do
    create_client
    @client.should be_valid
  end

end

def create_client(parameters = {})
  @client = Client.new(parameters.merge(Factory.attributes_for(:client)))
end
