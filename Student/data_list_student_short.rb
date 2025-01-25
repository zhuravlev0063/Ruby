require_relative 'data_list.rb'

class Data_list_student_short < Data_list
  

  def get_names
    ['fullname', 'git', 'contact']
  end

    def get_data
    result_data = []
    self.selected_indexes.each do |index|
      data = self.list[index]
      new_row = [self.index, data.fullname, data.git, data.contact] 
        result_data << new_row 
    end
    result_data
  end

  def row_from_attrs(data)
    return [data.fullname, data.git, data.contact]
  end

end