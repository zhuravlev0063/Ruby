# main.rb
require './person' 
require './student' 
require './student_short' 

# Создание объекта класса Student
student = Student.new(
  surname: "Иванов",
  firstname: "Иван",
  lastname: "Иванович",
  id: 1,
  phone_number: "+79101234567",
  telegram: "ivanov_telegram",
  email: "ivanov@example.com",
  git: "https://github.com/ivanov"
)

# Вывод информации о студенте
puts "Информация о студенте:"
puts student.getInfo

# Создание объекта класса Student_short из объекта Student
student_short = Student_short.new(student)

# Вывод информации о кратком представлении студента
puts "\nКраткая информация о студенте (через Student_short):"
puts student_short

# Создание объекта класса Student_short из строки
info_string = "Петров П.П. https://github.com/petrov Телефон: +79107654321"
student_short_from_string = Student_short.new(2, info_string)

# Вывод информации о кратком представлении студента из строки
puts "\nКраткая информация о студенте (через строку):"
puts student_short_from_string
