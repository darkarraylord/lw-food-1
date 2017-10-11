require_relative '../views/employee_view'

class EmployeesController
  def initialize(repository)
    @employee_repository = repository
    @view = EmployeeView.new
  end

  def list
    employees = @employee_repository.all
    @view.display(employees)
  end
end