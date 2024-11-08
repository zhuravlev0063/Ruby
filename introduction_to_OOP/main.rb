require_relative './student'
require_relative './student_short'

student1 = Student.new(surname: "Журавлёв", firstname:"Даниил", lastname: "Дмитриевич", id: "1", email: "gsgshej@mail.com", git: "ndhnhenhd", phone_number: "89123456789")

student2 = Student.new(surname: "Софронов", firstname:"Игорь", lastname: "Дмитриевич", id: "2", phone_number: "89876543210", telegram: "iehjwo", git: "jenhoew", email: "bdnblsns@mail.com")


puts student1
puts student2
puts student2.get_info
student2_short = Student_short.create_from_student(student2)
student1_short = Student_short.from_string(id: student1.id, string: student1.get_info)
puts student2
puts student1_short