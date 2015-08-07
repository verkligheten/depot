class Order < ActiveRecord::Base
  PAYMENT_TYPES = [ "Check", "Credit card", "Purchase order" ]
  has_many :line_items, dependent: :destroy
  # ...
  validates :name, :address, presence: true
  validates :pay_type, inclusion: PAYMENT_TYPES

  EMAIL_VALID_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: EMAIL_VALID_REGEX }


  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end