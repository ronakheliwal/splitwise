require_relative '../models/user.rb'
class UserManager
  attr_accessor :users

  def initialize
    self.users = {}
  end

  def add_user(id, name, email)
    user = User.new(id, name, email)
    users[user.id] = user
  end

  def get_user(user_id)
    users[user_id]
  end
end