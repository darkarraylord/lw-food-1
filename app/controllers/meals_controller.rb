require_relative '../views/meal_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @view = MealView.new
  end

  def list
    meals = @meal_repository.all
    @view.display(meals)
  end

  def add
    meal_attributes = @view.ask_for_name_and_price
    new_meal = Meal.new(meal_attributes)
    @meal_repository.add(new_meal)
  end
end