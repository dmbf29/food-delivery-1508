class Meal
  attr_reader :name, :price
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @price = attributes[:price]
  end

  def build_row
    [@id, @name, @price]
  end

  # Meal.headers (class method)
  def self.headers
    ['id', 'name', 'price']
  end
end

# Meal.new(name: 'spaghetti', price: 8000)
