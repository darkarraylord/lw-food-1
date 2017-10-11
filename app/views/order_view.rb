class OrderView
  def display(orders)
    orders.each do |order|
      puts "#{order.id} - #{order.delivered} - Meal: #{order.meal.name} - Customer: #{order.customer.name} - Employee: #{order.employee.username}"
    end
  end

  def get_id(type)
    puts "Please enter the #{type} id: "
    gets.chomp.to_i
  end
end