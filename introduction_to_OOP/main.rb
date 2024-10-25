require_relative 'student'

begin
  # Создание объектов с корректными номерами
  student1 = Student.new("Ivanov", "Ivan", "Ivanovich", id: 1, phone_number: "+7 (123) 456-78-90", telegram: "@ivanov", email: "ivanov@example.com", git: "https:github.com/ivanov")
  student2 = Student.new("Zhuravlev", "Daniil", "Dmitrievich", id: 2, email: "danil@example.com")

  # Вывод информации о студентах
  puts student1
  puts student2

  # Попытка создания объекта с некорректным номером телефона
  student3 = Student.new("Osipov", "Vasiliy", "Romanovich", id: 3, phone_number: "+7 123 456 78 90", telegram: "vasiliy", email: "vasiliy.com")
rescue ArgumentError => e
  puts e.message
end
