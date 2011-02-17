module EmployeesHelper
  def name_last_first(employee)
    header = employee.last_name
    unless employee.first_name.blank?
      header += ", #{employee.first_name}"
    end
  end

  def employee_panel(employee, &block)
    render :layout => 'layouts/panel',
      :locals => {
        :id => 'employee',
        :title => "Employee",
        :subtitle => name_last_first(employee) }, 
      &block
  end

  def employees_panel(&block)
    render :layout => 'layouts/panel',
      :locals => {
        :id => 'employees',
        :title => "Employees" },
      &block
  end
 end
