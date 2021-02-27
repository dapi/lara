require "test_helper"

class CalculatorTest < ActiveSupport::TestCase
  test "не выражение" do
    c = Calculator.new 'a2+2'
    refute c.is_expression?
  end
   test "выражение" do
     c = Calculator.new '2 + 2,1'
     assert c.is_expression?
     assert_equal c.call, 4.1
   end
end
