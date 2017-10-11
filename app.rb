require_relative 'app/repositories/customer_repository'
require_relative 'app/controllers/customers_controller'
require_relative 'app/repositories/meal_repository'
require_relative 'app/controllers/meals_controller'
require_relative 'app/repositories/employee_repository'
require_relative 'app/controllers/employees_controller'
require_relative 'app/repositories/order_repository'
require_relative 'app/controllers/orders_controller'
require_relative 'router'

customers_csv = 'data/customers.csv'
customer_repository = CustomerRepository.new(customers_csv)
customers_controller = CustomersController.new(customer_repository)

meals_csv = 'data/meals.csv'
meal_repository = MealRepository.new(meals_csv)
meals_controller = MealsController.new(meal_repository)

employees_csv = 'data/employees.csv'
employee_repository = EmployeeRepository.new(employees_csv)
employees_controller = EmployeesController.new(employee_repository)

orders_csv = 'data/orders.csv'
order_repository = OrderRepository.new(orders_csv, meal_repository, customer_repository, employee_repository)
orders_controller = OrdersController.new(order_repository, meal_repository, customer_repository, employee_repository)

router = Router.new(meals_controller, customers_controller, employees_controller, orders_controller)
router.run
