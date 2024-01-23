require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # tell the view to ask for username
    username = @sessions_view.ask_for('username')
    # tell the view to ask for password
    password = @sessions_view.ask_for('password')
    # ask the employee repo for the employee with the username
    employee = @employee_repository.find_by_username(username)
    # see if the password matches
    # if it does... "login"
    # if it doesnt... try again
    # if employee&.password == password
    if employee && employee.password == password
      @sessions_view.welcome(employee)
      return employee
    else
      @sessions_view.wrong_credentials
      login
    end
  end
end
