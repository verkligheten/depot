require 'test_helper'

class UserTest < ActiveSupport::TestCase

 test "should not delete last user" do
  user = User.new
  assert_raises("Can't delete last user"){User.destroy_all}
 end

 test "user should be valid" do
  user = User.create
  refute user.valid?
  refute user.persisted?
 end
end
