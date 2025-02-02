class Student_list_JSON

  def read_list_of_students(path)
    file = File.open(path, 'r')
    
    list = JSON.parse(file)
    list.map do |object|
      Student.new(**object)
    end
    self.students_list = list
  end

  def write_list_of_students(path, list = self.student.list)
    data = list.map do |object|
      object.to_h
    end
    File.open(path, 'w') do |file|
      file.write(JSON.pretty_generate(data))
    end
  end

  def get_by_id(id)
    self.students_list.find do |student|
      student.id == id
    end
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    k = 1 if k < 1 
    if students_list[k * n]
      students_list[((k-1) * n)...(k*n)]
    else
      raise IndexError, 'Индекс не в диапозоне'
  end

  def sort 
    self.students_list.sort_by do |student|
      [student.surname, student.firstname]
    end
  end

  def input_student(student)
    self.students_list.push(student)
  end

  def replace_by_id(student)
    self.students_list.map do |object|
      if object.id == student.id
        object = student
      end
    end
  end

  def delete_by_id(id)
    self.students_list.delete_if do |student|
      student.id == id
    end
  end
  def get_student_short_count
    self.students_list.count
  end
  private
  attr_accessor :students_list

end