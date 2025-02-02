require_relative 'data_table'

class Data_list

  def initialize(list)
    self.list = list
    self.selected_indexes = []
    self.index = 0
  end
  
  def get_select(index)
    self.selected_indexes = list[index]
  end
  
  def clear_selected
    self.selected_indexes = []
  end

  def select(index)
    raise "Индекс вне диапазона" if index < 0 || index >= list.length
    self.selected_indexes << index
  end
  
  def get_names
    raise NotImplementedError, "Must be implemented!"
  end

  def get_data
    result_data = []
    self.selected_indexes.each do |index|
      data = self.list[index]
      new_row = [self.index].concat(row_from_attrs(data))
      result_data << new_row 
      self.index+=1
    end
    result_table = Data_table.new(result_data)
  end

  def list=(list)
    if list.is_a?(Array) && list.length == get_names.length + 1
      self.list = list
    else
      raise ArgumentError, "Wrong list format"
    end
  end

  private

  attr_accessor :selected_indexes, :index
  attr_reader :list

  def row_from_attrs(data) 
    raise NotImplementedError, "Must be implemented!"
  end

end