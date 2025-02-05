require_relative 'data_list_student_short'
require_relative 'strategy'

class Student_list

  attr_reader :strategy

  def initialize
    self.strategy = Strategy.new
  end


  def get_by_id(id)
    result = self.strategy.read_list_of_students.find do |student|
      student.id == id
    end
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    k = 1 if k < 1 
    student_list = self.strategy.read_list_of_students
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
    students_list = self.strategy.read_list_of_students.sort_by do |student|
      student.fullname
    end
  end

  def insert_student(student)
    students_list = self.strategy.read_list_of_students
    
    if (unique_student?(student))
      students_list.push(student)
    else
      raise ArgumentError, 'Student already exists'
    end

    self.strategy.write_list_of_students(students_list)
  end

  def replace_by_id(student)
    student_list = self.strategy.read_list_of_students.map do |object|
      if object.id == student.id
        object = student
      end
    end
    self.strategy.write_list_of_students(student_list)
  end

  def delete_by_id(id)
    student_list = self.strategy.read_list_of_students.delete_if do |student|
      student.id == id
    end
    self.strategy.write_list_of_students(student_list)
  end
  
  def get_student_short_count
    students_list = self.strategy.read_list_of_students
    students_list.count
  end


  private

  
  def strategy=(strategy)
    if strategy.is_a?(Strategy)
      @strategy = strategy
    else 
      raise TypeError, 'Wrong type of strategy'
    end
  end
  
  def unique_student?(student)
    unigue_git?(student.git) && unique_phone?(student.phone) && unique_email?(student.email) && unique_telegram?(student.telegram)
  end

  def unigue_git?(git)
    unique_attr?(:git, git)
  end

  def unique_phone?(phone)
    unique_attr?(:phone, phone)
  end

  def unique_email?(email)
    unique_attr?(:email, email)
  end

  def unique_telegram?(telegram)
    unique_attr?(:telegram, telegram)
  end

  def unique_attr?(symbol, value)

    tree = Binary_tree.new
    self.strategy.read_list_of_students.each do |student|
      student.unique_indicator = symbol
      tree.add(student)
    end

    tree.iterator.each do |student|
      if student.unique_indicator == value
        return false
      end
    end
    true

  end 

end