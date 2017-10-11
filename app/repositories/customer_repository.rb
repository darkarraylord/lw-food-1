require 'pry-byebug'
require 'csv'
require_relative '../models/customer'

class CustomerRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @customers = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def find(id)
    @customers.find do |customer|
      customer.id == id
    end
  end

  def all
    @customers
  end

  def add(customer)
    customer.id = @next_id
    @customers << customer
    @next_id += 1
    save_csv
  end

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, options) do |row|
      customer_attributes = {
        id: row[:id].to_i,
        name: row[:name],
        address: row[:address].to_i,
      }

      @next_id += 1
      @customers << Customer.new(customer_attributes)
    end
  end

  def save_csv
    options = { write_headers: true, headers: ['id', 'name', 'address'] }
    CSV.open(@csv_file, 'wb', options) do |csv|
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end
end
