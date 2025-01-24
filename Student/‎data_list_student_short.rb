require_relative 'data_list.rb'
require_relative 'data_table.rb'

class Data_list_student_short < Data_list
  

  def get_names
    ['fullname', 'git', 'contact']
  end

  private

  def row_from_attrs(data)
    return [data.initials, data.git, data.contact]
  end
end