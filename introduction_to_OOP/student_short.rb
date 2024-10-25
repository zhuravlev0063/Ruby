require "./class_student.rb"

class Student_short
  attr_reader :id, :name, :git, :contact

  def initialize(*args)
    if args.length == 1 && args[0].is_a?(Student)
      # Инициализация на основе объекта класса Student
      student_info = args[0].getInfo.split
      @id = args[0].id
      @name = "#{student_info[0]} #{student_info[1]}" # Фамилия и инициалы
      @git = student_info[2]
      @contact = student_info[3..-1].join(" ")
    elsif args.length == 2 && args[0].is_a?(Integer) && args[1].is_a?(String)
      # Инициализация на основе id и строки параметров
      @id = args[0]
      params = Student_short.parse_string_params(args[1])
      @name = "#{params[0]} #{params[1]}" # Фамилия и инициалы
      @git = params[2]
      @contact = params[3..-1].join(" ")
    else
      raise ArgumentError, "Некорректные аргументы конструктора"
    end
  end

  # Метод для парсинга строки параметров
  def self.parse_string_params(str_params)
    str_params.split
  end

  # Метод для вывода информации об объекте
  def to_s
    "#{@id} #{@name} Git: #{@git}, Контакт: #{@contact}"
  end
end
