require_relative 'data_list_student_short'
require_relative 'strategy'
require_relative './data_list.rb'
require_relative './student_list_json.rb'
require_relative 'data_table'

class Student_list
  attr_accessor :strategy, :students


  def initialize(strategy)
    self.strategy = strategy
    self.students = read_list_of_students
  end

  def read_list_of_students 
    self.strategy.read_list_of_students 
  end

  def write_list_of_students
    self.strategy.write_list_of_students(students) 
  end


  def get_by_id(id)
    result = self.students.find do |student|
      student.id == id
    end
  end
  def count_of_rows
    @list.size
  end

  # Метод для подсчёта количества столбцов
  def count_of_columns
    return 0 if @list.empty?
    get_names.size
  end

  
  def get_k_n_student_short_list(k, n, data_list = nil)
    start_index = (k - 1) * n
    end_index = start_index + n - 1
    short_students = students[start_index..end_index]
    data_list.offset = (k - 1) * n
    data_list.set_list(short_students)
    data_list
  end

  
  def sort_students_by_full_name
    students.sort_by! { |student| student.fullname }
  end
  
  
  
  def insert_student(student)
    students_list = self.students
    if (unique?(student))
      students_list.push(student)
    else
      raise ArgumentError, 'Student already exists'
    end
  end
  def replace_by_id(student)
    student_list = self.students.map do |object|
      if object.id == student.id
        object = student
      end
    end
  end
  def delete_by_id(id)
    student_list = self.students.delete_if do |student|
      student.id == id
    end

  end
  
  def get_student_short_count
    students_list = self.students
    students_list.count
  end

  
  
  private
  def unique?(student)
    students.none? { |student_arr| student_arr==student }
  end
 
end 