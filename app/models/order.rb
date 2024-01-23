class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee

  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # INSTANCE of a a meal
    @customer = attributes[:customer] # INSTANCE of a a customer
    @employee = attributes[:employee] # INSTANCE of a a employee
    @delivered = attributes[:delivered] || false # boolean
  end

  # attr_reader but for a boolean
  def delivered?
    @delivered
  end

  # attr_writer (changing the state of delivered)
  def deliver!
    @delivered = true
  end
end
