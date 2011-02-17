module SearchesHelper
  def search_result(result)
    case result.class
      when Client   then render "clients/search_result", :client => result
      when Patient  then render "patients/search_result", :patient => result
      when Employee then render "employees/search_result", :employee => result
    end
  end
end
