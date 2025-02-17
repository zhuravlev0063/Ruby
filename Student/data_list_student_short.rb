require_relative 'data_list.rb'

class Data_list_student_short < Data_list
  

  def get_names
    ['index', 'fullname', 'git', 'contact']
  end


  def row_from_attrs(data)
    return [ data.fullname, data.git, data.contact]
  end
end