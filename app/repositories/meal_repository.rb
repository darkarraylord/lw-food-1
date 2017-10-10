# DONE - maintain a list of meals
# DONE - add meal to a list
# DONE - add autoincrementing of ids
# DONE - save to csv
# DONE - load from a csv
# DONE - all method to return all the meals
# DONE - find method

require 'pry-byebug'
require 'csv'
require_relative '../models/meal'

class MealRepository
  def initialize(csv_file)
    @csv_file = csv_file
    @meals = []
    @next_id = 1
    load_csv if File.exist?(@csv_file)
  end

  def find(id)
    @meals.find do |meal|
      meal.id == id
    end    
  end

  def all
    @meals
  end

  def add(meal)
    meal.id = @next_id
    @meals << meal
    @next_id += 1
    save_csv
  end

  def load_csv
    options = { headers: :first_row, header_converters: :symbol }
    CSV.foreach(@csv_file, options) do |row|
      meal_attributes = {
        id: row[:id].to_i,
        name: row[:name],
        price: row[:price].to_i,
      }

      @next_id += 1
      @meals << Meal.new(meal_attributes)
    end
  end

  def save_csv
    options = { write_headers: true, headers: ['id', 'name', 'price'] }
    CSV.open(@csv_file, 'wb', options) do |csv|
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end
end

repo = MealRepository.new('data/meals2.csv')
p repo


