class Employee
  attr_accessor :id, :username, :role
  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @role = attributes[:role]
  end
end
