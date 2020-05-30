class CommandValidator
  require_relative '../models/split_types.rb'
  require_relative '../exceptions/exceptions.rb'

  attr_accessor :command

  VALID_COMMANDS = [COMMANDS::EXIT, COMMANDS::EXPENSE, COMMANDS::SETTLE, COMMANDS::CUSTOM_PAY]

  def initialize(command)
    self.command = command
  end

  def call
    raise InvalidCommand unless VALID_COMMANDS.include?(command)
  end

end