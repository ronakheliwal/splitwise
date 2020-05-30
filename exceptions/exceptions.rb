class InvalidCommand < StandardError
  attr_reader :message
  def initialize(message=nil)
    @message = message || 'Invalid Input'
  end
end

class InvalidSplitType < StandardError

  attr_reader :message

  def initialize(message=nil)
    @message = message || 'Invalid Split Type'
  end
end


class InvalidShareAmount < StandardError

  attr_reader :message

  def initialize(message=nil)
    @message = message || 'Sum of shares for each user is not equal to amount to be split'
  end
end

class InvalidSharePercent < StandardError

  attr_reader :message

  def initialize(message=nil)
    @message = message || 'Toal percent for each user is less tha 100'
  end
end