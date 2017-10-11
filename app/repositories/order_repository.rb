require 'pry-byebug'
require 'csv'
require_relative '../models/order'
require_relative 'meal_repository'
require_relative 'customer_repository'
require_relative 'employee_repository'

class OrderRepository
  def initialize(csv_file, meal_repository, customer_repository, employee_repository)
    @csv_file = csv_file
    @orders = []
    @next_id = 1
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    load_csv if File.exist?(@csv_file)
  end

  def find(id)
    @orders.find do |order|
      order.id == id
    end
  end

  def all
    @orders
  end

  def add(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, options) do |row|
      order_attributes = {
        id: row[:id].to_i,
        delivered: row[:delivered] == "true" ? true : false,
        meal: @meal_repository.find(row[:meal_id].to_i),
        customer: @customer_repository.find(row[:customer_id].to_i),
        employee: @employee_repository.find(row[:employee_id].to_i),
      }

      @next_id += 1
      @orders << Order.new(order_attributes)
    end
  end

  def save_csv
    options = { write_headers: true, headers: ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id'] }
    CSV.open(@csv_file, 'wb', options) do |csv|
      @orders.each do |order|
        csv << [order.id, order.delivered, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end
end

# meal_repo = MealRepository.new('data/meals.csv')
# customer_repo = CustomerRepository.new('data/customers.csv')
# employee_repo = EmployeeRepository.new('data/employees.csv')
# repo = OrderRepository.new('data/orders.csv', meal_repo, customer_repo, employee_repo)
# first_order =  repo.all.first
# p first_order.employee





