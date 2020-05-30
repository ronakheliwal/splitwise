class Expense
  attr_accessor :amount, :paid_by, :splits

  def initialize(amount, paid_by, splits)
    self.amount = amount
    self.paid_by = paid_by
    self.user_share = splits
  end
end