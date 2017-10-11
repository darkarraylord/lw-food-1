require 'pry-byebug'
require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @employees = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def find(id)
    @employees.find do |employee|
      employee.id == id
    end
  end

  def all
    @employees
  end

  def add(employee)
    employee.id = @next_id
    @employees << employee
    @next_id += 1
    save_csv
  end

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, options) do |row|
      employee_attributes = {
        id: row[:id].to_i,
        username: row[:username],
        role: row[:role],
      }

      @next_id += 1
      @employees << Employee.new(employee_attributes)
    end
  end

  def save_csv
    options = { write_headers: true, headers: ['id', 'username', 'role'] }
    CSV.open(@csv_file, 'wb', options) do |csv|
      @employees.each do |employee|
        csv << [employee.id, employee.username, employee.role]
      end
    end
  end
end
