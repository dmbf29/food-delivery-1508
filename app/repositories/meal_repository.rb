require 'csv'
require_relative '../models/meal'

class MealRepository
  attr_reader :meals

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @next_id = 1
    @meals = [] # an array of MEAL INSTANCES
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def create(meal) # meal is an INSTANCE
    # set the id
    meal.id = @next_id
    # change the next id
    @next_id += 1
    # push into the arrray
    @meals << meal
    # save to the csv
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # attributes is acting like a hash (instance of CSV Row)
      # we have to convert all non-string values before the instance
      attributes[:id] = attributes[:id].to_i
      attributes[:price] = attributes[:price].to_i
      meal = Meal.new(attributes)
      @meals << meal
      @next_id = meal.id + 1
    end
  end

  def save_csv
    # if it exists, it overwrite it
    # if it doesnt exist, it creates it
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << ['id', 'name', 'price']
      csv << Meal.headers
      @meals.each do |meal|
        # csv << [meal.id, meal.name, meal.price]
        csv << meal.build_row
      end
    end
  end
end
