class ExpenseManager
  # require_relative '../models/'
  require_relative '../validators/split_type_validator.rb'
  require_relative 'user_manager.rb'

  attr_accessor :expenses, :balance_sheet, :user_manager

  SPLIT_TYPES = []
  
  def initialize(user_manager)
    self.expenses = []
    self.user_manager = user_manager
    initialize_balance_sheet
  end

  def add_expense(amount, split_type, paid_by, users)
    validate_split_type(split_type)
  end

  def get_all_balances
    no_balance = true
    balance_sheet.each do |user1, balances|
      balances.each do |user2, amount|
        print_balance(user_1, user_2, amount)
        no_balance = false
      end
    end
    puts "No Balances" if no_balance
  end

  private

  def split_equal
    
  end

  

  def validate_split_type(split_type)
    SplitTypeValidator.new(split_type).call
  end

  def initialize_balance_sheet
    self.balance_sheet = {}
    user_manager.users.keys.each do |user_id|
      balance_sheet[user_id] = {}
    end
  end

  def print_balances(user1, user_2, amount)
    u1 = user_manager.get_user(user1) 
    u2 = user_manager.get_user(user2)
    if amount > 0
      puts "#{u2.name} owes Rs. #{amount} to #{u1.name}"
    else
       puts "#{u1.name} owes Rs. #{amount} to #{u2.name}"
    end
  end
end