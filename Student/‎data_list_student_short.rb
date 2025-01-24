require_relative 'data_list.rb'
require_relative 'data_table.rb'
class Data_list_student_short < Data_list
  
  def get_data
    result_data = []
    self.selected_indexes.each do |index|
      data = self.list[index]
      new_row = [self.index, data.fullname, data.git, data.contact] 
        result_data << new_row 
    end
    result_data
  end
  def get_names
    ['fullname', 'git', 'contact']
  end
  private
  attr_accessor :index
end