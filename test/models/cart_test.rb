require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  test "quantity is increment when select product twice" do
    cart = Cart.create

    cart.add_product( products(:ruby).id ).save
    assert_equal 1, cart.line_items.count

    cart.add_product( products(:ruby).id ).save
    assert_equal 1, cart.line_items.count
    assert_equal 2, cart.line_items.first.quantity
  end

  test 'cart should update an existing line item when adding an existing product' do
    cart = Cart.create
    cart.add_product(products(:ruby).id).save

    cart.add_product(products(:ruby).id).save
    assert_equal 1, cart.line_items.count
  end

  test "cart should be created and destroyed" do
    assert_same Cart.count, Cart.destroy_all.count,
      "unable to destroy existing carts"
    Cart.create
    assert_equal 1, Cart.count, "unable to create cart"
    assert_equal 1, Cart.destroy_all.count, "unable to destroy cart"
  end

  test "cart should count total price of products in it" do
    cart = Cart.create
    line_item = LineItem.create(product_id: products(:ruby).id, cart_id: cart.id)
    line_item = LineItem.create(product_id: products(:one).id, cart_id: cart.id)
    assert_equal 59.49, cart.total_price
  end
end
