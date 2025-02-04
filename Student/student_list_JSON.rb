require 'json'
require_relative 'student_short'
require_relative 'student'

class StudentListJSON
  def initialize(path)
    @path = path
  end

  def read_list_of_students
    file = File.read(self.path)
    raise 'File is empty' if file.strip.empty?
    JSON.parse(file, symbolize_names: true).map do |object|
      Student.new(**object)
    end
  end
  def write_list_of_students(list)
    data = list.map do |object|
      object.to_h
    end
    File.open(self.path, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end

  def get_by_id(id)
    students_list = read_list_of_students

    students_list.find do |student|
      student.id == id
    end
  end


  def get_k_n_student_short_list(k = 1, n = 20)
    k = 1 if k < 1 
    student_list = read_list_of_students

    if student_list[k * n]
      student_short_list = student_list[((k-1) * n)...(k*n)].map do |student|
        Student_short.from_student(student)
      end
    else
      raise IndexError, 'Index out of range'
    end
  end
  def sort 
    students_list = read_list_of_students.sort_by do |student|
      student.fullname
    end
  end
  def insert_student(student)
    students_list = read_list_of_students
    students_list.push(student)

    write_list_of_students(students_list)
  end

  def replace_by_id(student)
    student_list = read_list_of_students.map do |object|
      if object.id == student.id
        object = student
      end
    end
    write_list_of_students(student_list)
  end

  def delete_by_id(id)
    students_list = read_list_of_students  # Сначала читаем список студентов
    students_list.delete_if do |student|    # Удаляем студентов с указанным ID
      student.id == id
    end
    write_list_of_students(students_list)   # Записываем обновленный список обратно в файл
  end

  def get_student_short_count
    students_list = read_list_of_students
    students_list.count
  end

  private
  attr_accessor :path
end