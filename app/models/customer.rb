class Customer
  attr_reader :name, :address
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @name = attributes[:name]
    @address = attributes[:address]
  end

  def build_row
    [@id, @name, @address]
  end

  # Customer.headers (class method)
  def self.headers
    ['id', 'name', 'address']
  end
end

# Meal.new(name: 'spaghetti', address: 8000)
