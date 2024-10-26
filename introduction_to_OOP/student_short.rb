# Подкласс Student_short представляет краткую информацию о студенте, наследуя основные атрибуты от класса Person.

require './person' # Подключение базового класса Person

class Student_short < Person
  # Определение атрибута для чтения контактной информации
  attr_reader :contact

  # Конструктор класса Student_short, который принимает два варианта аргументов
  def initialize(*args)
    # Первый вариант: инициализация на основе объекта класса Student
    if args.length == 1
      student_info = args[0].getInfo.split # Разделяем информацию о студенте на части
      @id = args[0].id
      @surname = student_info[0]
      @firstname = student_info[1]
      @git = student_info[2]
      @contact = student_info[4..-1].join(' ') # Объединяем оставшуюся информацию в строку контактов

    # Второй вариант: инициализация на основе ID и строки с остальной информацией
    elsif args.length == 2
      @id = args[0]
      params = self.class.parse_string_params(args[1]) # Разделяем строку с информацией на отдельные элементы
      @surname = params[0]
      @firstname = params[1]
      @git = params[2]
      @contact = params[3]
    end
  end

  # Метод класса для парсинга строки параметров
  def self.parse_string_params(str_params)
    str_params.split
  end

  # Метод для вывода строки с информацией о студенте
  def to_s
    "#{@id} #{@surname} #{@firstname} #{@git} #{@contact}"
  end
end
