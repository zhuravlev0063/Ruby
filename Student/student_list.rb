require_relative 'data_list_student_short'
require_relative 'strategy'

class Student_list

  attr_accessor :strategy, :students

  def initialize
    self.strategy = Strategy.new
    self.students = read_list_of_students
  end

  def read_list_of_students 
    self.strategy.read_list_of_students 
  end

  def write_list_of_students(students_list) 
    self.strategy.write_list_of_students 
  end


  def get_by_id(id)
    result = self.read_list_of_students.find do |student|
      student.id == id
    end
  end

  def get_k_n_student_short_list(k = 1, n = 2)
    k = 1 if k < 1 
    student_list = self.read_list_of_students
    if student_list[k * n]
      student_short_list = student_list[((k-1) * n)...(k*n)].map do |student|
        Student_short.about_student(student)
      end
      Data_list_student_short.new(student_short_list)
    else
      raise IndexError, 'Index out of range'
    end
  end

  def sort 
    students_list = self.read_list_of_students.sort_by do |student|
      student.fullname
    end
  end

  def insert_student(student)
    students_list = self.read_list_of_students
    
    if (unique?(student))
      students_list.push(student)
    else
      raise ArgumentError, 'Student already exists'
    end

    self.write_list_of_students(students_list)
  end

  def replace_by_id(student)
    student_list = self.read_list_of_students.map do |object|
      if object.id == student.id
        object = student
      end
    end
    self.write_list_of_students(student_list)
  end

  def delete_by_id(id)
    student_list = self.read_list_of_students.delete_if do |student|
      student.id == id
    end
    self.write_list_of_students(student_list)
  end
  
  def get_student_short_count
    students_list = self.read_list_of_students
    students_list.count
  end


  private

  def unique?(student)
  students.none? { |student_arr| student_arr==student }
  end


end