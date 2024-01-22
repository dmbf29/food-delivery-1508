require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # we need to get meals from meal repository
    meals = @meal_repository.all
    # tell the view to display the meals
    @meals_view.display(meals)
  end

  def add
    # have the view ask for the name
    name = @meals_view.ask_for('name')
    # have the view ask for the price
    price = @meals_view.ask_for('price').to_i
    # create an instance of a meal
    meal = Meal.new(name: name, price: price)
    # give the meal to the repository
    @meal_repository.create(meal)
  end
end
