class User
  attr_accessor :id, :name, :email

  def initialize(id, name, email)
    self.id = id
    self.name = name
    self.email = email
  end
end