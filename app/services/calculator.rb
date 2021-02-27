class Calculator
  REGEXP = /[^ 0-9\+\-\*\/\.\,\(\)]/

  def initialize(buffer)
    @buffer = buffer
  end

  def is_expression?
    buffer !~ REGEXP
  end

  def call
    Dentaku::Calculator.new.evaluate buffer.tr(',','.')
  end

  private

  attr_reader :buffer
end
