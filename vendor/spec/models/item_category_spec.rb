require 'spec_helper'

describe ItemCategory do

  before do
    @itemCategory = ItemCategory.new(item_id: 1, category_id: 1)
  end

  subject {@itemCategory}

  it {should respond_to(:category_id)}
  it {should respond_to(:item_id) }

  describe "when category_id is not null" do
    before {@itemCategory.category_id = nil}
    it { should_not be_valid }
  end

  describe "when category_id is an integer" do
    before {@itemCategory.category_id = 1.22 }
    it { should_not be_valid }
  end

  describe "when item_id is not null" do
    before {@itemCategory.item_id = nil}
    it { should_not be_valid }
  end

  describe "when item_id is not an integer" do
    before {@itemCategory.item_id = 1.33}
    it { should_not be_valid }
  end

  describe "when item_id and category_id are integers" do
    before {@itemCategory.item_id = 1
    @itemCategory.category_id = 2}
    it { should be_valid }
  end
end
