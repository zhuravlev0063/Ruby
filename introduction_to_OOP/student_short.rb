# class_student_short.rb
require './person' # Подключение класса Person

class Student_short < Person
  attr_reader :contact

  def initialize(*args)
    if args.length == 1
      student_info = args[0].getInfo.split
      @id = args[0].id
      @surname = student_info[0]
      @firstname = student_info[1]
      @git = student_info[2]
      @contact = student_info[4..-1].join(' ')
    elsif args.length == 2
      @id = args[0]
      params = self.class.parse_string_params(args[1])
      @surname = params[0]
      @firstname = params[1]
      @git = params[2]
      @contact = params[3]
    end
  end

  def self.parse_string_params(str_params)
    str_params.split
  end

  def to_s
    "#{@id} #{@surname} #{@firstname} #{@git} #{@contact}"
  end
end
