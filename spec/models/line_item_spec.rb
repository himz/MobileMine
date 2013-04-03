require 'spec_helper'

#:item, :cart, :item_id, :cart_id, :total_price,:user_id, :quantity, :line_item_type, :auction_id
describe LineItem do
  let(:line_item) { FactoryGirl.create(:line_item) }
  subject {line_item}

  it { should respond_to(:item_id)}
  it { should respond_to(:cart_id)}
  it { should respond_to(:total_price)}
  it { should respond_to(:user_id)}
  it { should respond_to(:quantity)}
  it { should respond_to(:line_item_type)}
  it { should respond_to(:auction_id)}
end
