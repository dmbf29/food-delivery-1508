require 'csv'
require_relative '../models/customer'

class CustomerRepository
  attr_reader :customers

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @next_id = 1
    @customers = [] # an array of customer INSTANCES
    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def create(customer) # customer is an INSTANCE
    # set the id
    customer.id = @next_id
    # change the next id
    @next_id += 1
    # push into the arrray
    @customers << customer
    # save to the csv
    save_csv
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |attributes|
      # attributes is acting like a hash (instance of CSV Row)
      # we have to convert all non-string values before the instance
      attributes[:id] = attributes[:id].to_i
      customer = Customer.new(attributes)
      @customers << customer
      @next_id = customer.id + 1
    end
  end

  def save_csv
    # if it exists, it overwrite it
    # if it doesnt exist, it creates it
    CSV.open(@csv_file_path, 'wb') do |csv|
      # csv << ['id', 'name', 'price']
      csv << Customer.headers
      @customers.each do |customer|
        # csv << [customer.id, customer.name, customer.price]
        csv << customer.build_row
      end
    end
  end
end
