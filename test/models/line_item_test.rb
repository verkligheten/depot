require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  fixtures :products

  test "line items should count total price" do
    line_item = LineItem.create(product_id: products(:ruby).id)
    assert_equal 49.50, line_item.product.price.to_f
    line_item.quantity = 2
    assert_equal 99, line_item.total_price
  end
end
