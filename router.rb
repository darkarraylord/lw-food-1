class Router
  def initialize(meals_controller)
    @meals_controller = meals_controller
  end

  def run
    loop do
      # 1. Print the menu
      print_menu
      # 2. Ask the user what he/she wants to do next?
      puts 'What do you want to do next?'
      print '> '
      action = gets.chomp.to_i
      # 3. Call the right controller method
      case action
      when 1 then @meals_controller.add
      when 2 then @meals_controller.list
      else
        puts 'Wrong action'
      end
    end
  end

  private

  def print_menu
    puts '1. Add a meal'
    puts '2. List available meals'
  end
end
