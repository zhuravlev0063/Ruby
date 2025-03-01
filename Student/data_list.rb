require_relative 'data_table'

class Data_list
  attr_accessor :offset
  def initialize(list,offset = 0)
    self.list = list
    self.selected_indexes = []
    self.index = 0
    self.count = 0
    self.observers = []
    self.offset = offset
  end
  
  def count_of_rows
    @list.size
  end

  # Метод для подсчёта количества столбцов
  def count_of_columns
    return 0 if @list.empty?
    get_names.size
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
    result_data = [self.get_names]
    self.list.each_with_index do |row,index|
      data = self.list[index]
      new_row = [index+1+self.offset].concat(row_from_attrs(data))
      result_data << new_row 

    end
    Data_table.new(result_data)
  end

  def add_observer(view)
    self.observers << view
  end

  def notify
    puts "Уведомление наблюдателей..."
    puts "Количество наблюдателей: #{self.observers.size}"
    
    self.observers.each do |observer|
      names = self.get_names
      data = self.get_data
      
      puts "Уведомление наблюдателя с именами: #{names.inspect} и данными: #{data.inspect}"
      
      begin
        observer.set_table_params(get_names, self.count)
        observer.set_table_data(self.get_data)
      rescue => e
        puts "Ошибка при обновлении наблюдателя: #{e.message}"
      end
    
    end
  end
  
  def set_list(list)
    unless list.is_a?(Array)
      raise ArgumentError, 'List must be an array.'
    end
   
    self.list = list
  end

  attr_accessor :observers, :count
  
  attr_accessor :selected_indexes, :index, :list

  def row_from_attrs(data) 
    raise NotImplementedError, "Must be implemented!"
  end
  def correct_type?(var)
    if var.is_a?(Array)
      var.all?{ |item| item.is_a?(element_type) }
    else
      false
    end
  end

  def element_type
    Object
  end

end