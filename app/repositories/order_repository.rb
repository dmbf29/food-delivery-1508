require_relative '../models/order'

class OrderRepository
  def initialize(csv_file_path, meal_repository, customer_repository, employee_repository)
    @csv_file_path = csv_file_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @next_id = 1
    @orders = []
    load_csv if File.exist?(@csv_file_path)
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end

  # save the new instance of an order into our array, give an id, and  save csv
  def create(order)
    order.id = @next_id
    @next_id += 1
    @orders << order
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # convert any non-string values first

      attributes[:id] = attributes[:id].to_i
      attributes[:delivered] = attributes[:delivered] == 'true'

      attributes[:meal_id] = attributes[:meal_id].to_i
      meal = @meal_repository.find(attributes[:meal_id])
      attributes[:meal] = meal

      attributes[:customer_id] = attributes[:customer_id].to_i
      customer = @customer_repository.find(attributes[:customer_id])
      attributes[:customer] = customer

      attributes[:employee_id] = attributes[:employee_id].to_i
      employee = @employee_repository.find(attributes[:employee_id])
      attributes[:employee] = employee

      # create an instance of an order
      order = Order.new(attributes)
      # add the order into the orders array
      @orders << order
      @next_id = order.id + 1
    end
  end

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << ['id', 'delivered', 'meal_id', 'customer_id', 'employee_id']
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

end
