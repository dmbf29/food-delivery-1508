require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository

    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  # user actions
  def list_undelivered_orders
    # ask the order repo for all the undelivered orders
    orders = @order_repository.undelivered_orders
    # give those orders to the orders view
    @orders_view.display(orders)
  end

  def add
    # ask the meal repository for all the meals
    # tell the meals view to display the meals
    # ask user which meal they want to choose (index)
    # get the one meal from the meals array using the index
    meals = @meal_repository.all
    @meals_view.display(meals)
    index = @meals_view.ask_for('number').to_i - 1
    meal = meals[index]

    # ask the customer repository for all the customers
    # tell the customers view to display the customers
    # ask user which customer they want to choose (index)
    # get the one customer from the customers array using the index
    customers = @customer_repository.all
    @customers_view.display(customers)
    index = @customers_view.ask_for('number').to_i - 1
    customer = customers[index]

    # ask the employee repository for all the riders
    # tell the employees view to display the employees
    # ask user which employee they want to choose (index)
    # get the one employee from the employees array using the index
    employees = @employee_repository.all_riders
    @employees_view.display(employees)
    index = @employees_view.ask_for('number').to_i - 1
    employee = employees[index]

    # create an instance of an order
    order = Order.new(meal: meal, customer: customer, employee: employee)
    # give the instance to the order repository
    @order_repository.create(order)
  end

  def list_my_undelivered_orders(employee)
    # ask the order repo for my undelivered order
    orders = @order_repository.my_undelivered_orders(employee)
    # give the order to the view
    @orders_view.display(orders)
  end

  def mark_as_delivered(employee)
    orders = @order_repository.my_undelivered_orders(employee)
    @orders_view.display(orders)
    # ask which order was just delivered?
    index = @orders_view.ask_for('number').to_i - 1
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end
end
