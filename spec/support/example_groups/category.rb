module ExampleGroupHelpers
  shared_examples_for "all categories" do
    it { should be_valid }
    it { should have_fields(:name, :description) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
