module EmployeesHelper
  def employee_panel(employee, &block)
    render :layout => 'layouts/panel',
      :locals => {
        :id => 'employee',
        :title => "Employee",
        :subtitle => employee.full_name },
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
