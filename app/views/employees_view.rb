class EmployeesView
  def display(employees) # employees is an array of INSTANCES
    if employees.any?
      employees.each_with_index do |employee, index|
        puts "#{index + 1}.) #{employee.username} - #{employee.role}"
      end
    else
      puts 'No employees yet 🍽️'
    end
  end

  def ask_for(thing)
    puts "What's the #{thing}?"
    gets.chomp
  end
end
