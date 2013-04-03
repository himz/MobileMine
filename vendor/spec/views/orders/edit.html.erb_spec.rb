require 'spec_helper'

describe "orders/edit" do
  before(:each) do
    @order = assign(:order, stub_model(Order,
      :buyer_id => 1,
      :seller_id => 1,
      :item_id => 1,
      :state => 1
    ))
  end

  it "renders the edit order form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => orders_path(@order), :method => "post" do
      assert_select "input#order_buyer_id", :name => "order[buyer_id]"
      assert_select "input#order_seller_id", :name => "order[seller_id]"
      assert_select "input#order_item_id", :name => "order[item_id]"
      assert_select "input#order_state", :name => "order[state]"
    end
  end
end
