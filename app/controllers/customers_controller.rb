require_relative '../views/customer_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @view = CustomerView.new
  end

  def add
    attributes = @view.ask_for_name_and_address
    new_customer = Customer.new(attributes)
    @customer_repository.add(new_customer)
  end

  def list
    customers = @customer_repository.all
    @view.display(customers)
  end
end
