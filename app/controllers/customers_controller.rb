require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # we need to get customers from customer repository
    customers = @customer_repository.all
    # tell the view to display the customers
    @customers_view.display(customers)
  end

  def add
    # have the view ask for the name
    name = @customers_view.ask_for('name')
    # have the view ask for the address
    address = @customers_view.ask_for('address')
    # create an instance of a customer
    customer = Customer.new(name: name, address: address)
    # give the customer to the repository
    @customer_repository.create(customer)
  end
end
