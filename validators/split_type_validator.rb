class SplitTypeValidator
  require_relative '../models/split_types.rb'
  require_relative '../exceptions/exceptions.rb'

  attr_accessor :split_type

  SPLIT_TYPES = [SplitTypes::EXACT, SplitTypes::PERCENT, SplitTypes::EQUAL]
  def initialize(split_type)
    self.split_type = split_type
  end

  def call
    raise InvalidSplitType unless SPLIT_TYPES.include?(split_type)
  end
end