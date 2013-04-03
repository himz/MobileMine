require 'spec_helper'

describe Category do
 # before do
  #  @category = Category.new(name: "Phone", image_url: "/imag")
  #end

  let(:category) { FactoryGirl.create(:category) }
  subject {category}

  it { should respond_to(:name)}
  it { should respond_to(:image_url)}

  context "Validations" do

    it "has a valid factory" do
      category.should be_valid
    end

    describe "When name is null" do
      before { category.name = nil }
      it { should_not be_valid }
    end
    describe "When name is not null" do
      before { category.name = "phone" }
      it { should be_valid }
    end
  end

  it "changes the number of categories when adding a New category" do
    @category=Category.new(name: "Feature Phone", image_url: "someURL")
    expect {@category.save}.to change {Category.count}.by(1)
  end

  it "does not change the number of categories when adding a New category if data is not valid" do
    @category=Category.new(name: "", image_url: "someURL")
    expect {@category.save}.to change {Category.count}.by(0)
  end

end
