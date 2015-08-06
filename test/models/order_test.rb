require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  fixtures :products

  test "order depend destroy" do
    cart = Cart.create
    cart.add_product(products(:ruby).id)
    cart.save!
    assert cart.persisted?
    order = Order.create(name: "order1", address: "address_test", email: "test@email.com", pay_type: "Check")
    order.add_line_items_from_cart(cart)
    order.save!
    assert_nil LineItem.find_by(order_id: cart.id)
  end

  test "order should be valid" do
    order = Order.create
    refute order.valid?
    refute order.persisted?
  end

  test "order shuld have line items from cart" do
    cart = Cart.create
    cart.add_product(products(:ruby).id)
    cart.save!
    order = Order.create(name: "test_order", address: "test_address", email: "test@email.com", pay_type: "Check")
    order.add_line_items_from_cart(cart)
    assert_not_nil order.line_items
    assert_nil order.line_items.each{|i| return i.cart_id}
    end
end
