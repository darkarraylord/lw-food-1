class MealView
  def display(meals)
    meals.each do |meal|
      puts "#{meal.id} - #{meal.name} - #{meal.price}"
    end
  end

  def ask_for_name_and_price
    puts "Enter a meal name: "
    name = gets.chomp
    puts "Enter a price for #{name}"
    price = gets.chomp.to_i

    { name: name, price: price }
  end
end