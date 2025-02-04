class Strategy
  def read_list_of_students 
    raise NotImplementedError, 'Must be implemented in children classes'
  end
  def write_list_of_students(students_list) 
    raise NotImplementedError, 'Must be implemented in children classes'
  end
  private
  attr_accessor :path
end