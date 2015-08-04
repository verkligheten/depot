require 'test_helper'

class CartTest < ActiveSupport::TestCase
  fixtures :products

  test "quantity is increment when select product twice" do
    cart = Cart.create

    cart.add_product( products(:ruby).id ).save!
    assert_equal(1, cart.line_items.count)

    cart.add_product( products(:ruby).id ).save!
    assert_equal(1, cart.line_items.count)
    assert_equal(2, cart.line_items.first.quantity)
  end
end
