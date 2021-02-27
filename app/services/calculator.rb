class Calculator
  REGEXP = /[^ 0-9\+\-\*\/\.\,\(\)]/

  def initialize(buffer)
    @buffer = clean buffer
  end

  def is_expression?
    buffer !~ REGEXP
  end

  def call
    Dentaku::Calculator.new.evaluate buffer
  end

  private

  attr_reader :buffer

  def clean(buffer)
    buffer.tr(',','.').tr('?','').tr(':','/')
  end
end
