require_relative 'student'

# Создание объектов
student1 = Student.new(last_name: "Ivanov", first_name: "Ivan", middle_name: "Ivanovich", id: 1, phone: "123-456", telegram: "@ivanov", email: "ivanov@example.com", git: "github.com/ivanov")
student2 = Student.new(last_name: "Zhuravlev", first_name: "Daniil", middle_name: "Dmitrievich", id: 2, email: "petrov@example.com")
student3 = Student.new(last_name: "Osipov", first_name: "Vasiliy", middle_name: "Romanovich", id: 3, git: "github.com/sidorov")

# Вывод информации о студентах
puts student1
puts student2
puts student3
