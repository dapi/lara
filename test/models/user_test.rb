require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "parse full_name" do
    full_name = 'Иванова Мария Ивановна'
    user = User.new
    user.full_name = full_name
    assert_equal user.firstname, 'Мария'
    assert_equal user.surname, 'Иванова'
    assert_equal user.middlename, 'Ивановна'
    assert_equal user.full_name, full_name
  end
end
