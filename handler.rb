class Handler
  require_relative 'services/user_manager.rb'
  require_relative 'services/expense_manager.rb'
  require_relative 'models/user.rb'
  require_relative 'models/commands.rb'
  require_relative 'exceptions/exceptions.rb'

  attr_accessor :user_manager, :expense_manager

  def initialize
    self.user_manager = UserManager.new
    add_users
    self.expense_manager = ExpenseManager.new(user_manager)
  end

  def call
    loop do
      input = gets
      break if input.strip.downcase == 'exit'
      begin 
        process_input(input)
      rescue StandardError => e
        puts e.message
      end
    end
  end

  def process_input(input)
    sliced_input = input.split(' ')
    command = sliced_input[0]
    params = sliced_input[1..-1]
    case command
    when Commands::SHOW
      expense_manager.get_all_balances
    when Commands::EXPENSE
      add_expenses(params)
    else
      raise InvalidCommand
    end
  end

  def add_users
    user_manager.add_user('u1', 'Jon', 'jon@gmail.com')
    user_manager.add_user('u2', 'Sansa', 'jon@gmail.com')
    user_manager.add_user('u3', 'Robb', 'jon@gmail.com')
    user_manager.add_user('u4', 'Arya', 'jon@gmail.com')
  end

  def add_expenses(params)
    split_type = params[0]
    SplitTypeValidator.new(split_type).call
    raise InvalidCommand if params.size < 5
    paid_by = params[1]
    
    paid_by_user = user_manager.get_user(paid_by)

    if paid_by.nil?
      puts 'ivalid user #{paid_by}'
      return
    end

    amount = params[2].to_f
    if amount == 0
      puts 'enter a valid numeric amount'
      return
    end

    params = params[3..-1]
    puts params
    spilts = []
    users = []
    exact_shares = []
    percents = []

    step_size = split_type == SplitTypes::EQUAL ? 1 : 2

    get_user_for_splitting(params, step_size, users)
    get_exact_shares_for_splitting(params, step_size, exact_shares)
    get_percents_for_splitting(params, step_size, percents)

    validate_shares(split_type, amount, exact_shares, percents)

  end

  def get_user_for_splitting(params, step_size, users)
    for i in (0..params.size-1).step(step_size) do
      user =  user_manager.get_user(params[i])
      if user.nil?
        puts "invalid user #{params[i]}"
        return
      end
      users.push(user)
    end
  end

  def get_exact_shares_for_splitting(params, step_size, exact_shares)
    get_share_for_splitting(params, step_size, exact_shares)
  end

  def get_percents_for_splitting(params, step_size, percents)
    get_share_for_splitting(params, step_size, percents)
  end

  def get_share_for_splitting(params, step_size, shares)
     for i in (1..params.size-1).step(step_size) do
        shares.push(params[i].to_f)
     end
  end

  def validate_shares(split_type, amount, exact_shares, percents)
    case split_type
    when SplitTypes::EXACT
      raise InvalidShareAmount if exact_shares.sum != amount
    when SplitTypes::PERCENT
      raise InvalidSharePercent if exact_shares.sum != 100
    else
    end
  end

end

Handler.new.call