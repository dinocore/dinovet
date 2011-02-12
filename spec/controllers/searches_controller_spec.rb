require 'spec_helper'

describe SearchesController do
  disconnect_sunspot

  describe "GET 'show'" do
    before { get :show }

    it { response.should be_success }

    it "should set @results" do
      assigns[:results].should be_an_instance_of(Array)
    end
  
    it { response.should render_template(:show) }
  end
end
