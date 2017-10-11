class CustomerView
  def display(customers)
    customers.each do |customer|
      puts "#{customer.id} - #{customer.name} - #{customer.address}"
    end
  end

  def ask_for_name_and_address
    puts "Enter a customer name: "
    name = gets.chomp
    puts "Enter #{name}'s address: '"
    address = gets.chomp.to_i

    { name: name, address: address }
  end
end
