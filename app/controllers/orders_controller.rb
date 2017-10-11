require_relative '../views/order_view'
require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/employee_view'

class OrdersController
  def initialize(order_repository, meal_repository, customer_repository, employee_repository)
    @order_repository = order_repository
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_view = OrderView.new
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @employee_view = EmployeeView.new
  end

  def add
    # display all the Meals
    meals = @meal_repository.all
    @meal_view.display(meals)
    # get the Meal id
    meal_id = @order_view.get_id("Meal")

    # display all the Customers
    customers = @customer_repository.all
    @customer_view.display(customers)
    # get the Customer id
    customer_id = @order_view.get_id("Customer")

    # display all the Employees
    employees = @employee_repository.all
    @employee_view.display(employees)
    # get the Employee id
    employee_id = @order_view.get_id("Employee")

    meal = @meal_repository.find(meal_id)
    customer = @customer_repository.find(customer_id)
    employee = @employee_repository.find(employee_id)
    order = Order.new(meal: meal, customer: customer, employee: employee)

    @order_repository.add(order)
  end

  def list
    orders = @order_repository.all
    @order_view.display(orders)
  end
end
