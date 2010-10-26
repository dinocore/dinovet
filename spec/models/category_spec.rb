require 'spec_helper'

describe Category do
  let(:category) { create_category }
  subject { category }
  it_should_behave_like "all categories"
end

def create_category(parameters = {})
  Category.new(Factory.attributes_for(:category).merge(parameters))
end
