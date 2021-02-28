class Calculator
  EXCLUDE_REGEXP = /[^ 0-9\+\-\*\/\.\,\(\)]/
  INCLUDE_REGEXP = /[ 0-9\+\-\*\/\.\,\(\)]/

  def initialize(buffer)
    @buffer = clean buffer.to_s
  end

  def is_expression?
    buffer !~ EXCLUDE_REGEXP && buffer =~ INCLUDE_REGEXP
  end

  def call
    Dentaku::Calculator.new.evaluate buffer
  end

  private

  attr_reader :buffer

  def clean(buffer)
    buffer.to_s.tr(',','.').tr('?','').tr(':','/')
  end
end
