module ExampleGroupHelpers
  shared_examples_for "all categories" do
    it { should be_valid }
    it { should have_fields(:name, :description) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    describe ".list" do
      before do
        5.times { Factory.create(:category) }
        @categories = Category.all.collect { |c| [c.name, c.id] }
      end

      it "should return an array of name, id pairs" do
        Category.list.should == @categories
      end
    end
  end
end
