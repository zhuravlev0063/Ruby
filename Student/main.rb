require_relative './student'
require_relative './binary_tree'
require_relative './student_short'
require_relative './data_list_student_short'
require_relative './student_list_json'
require_relative './student_list_yaml'
require_relative './file_handler'

dan= Student.new(
  id: "1",
  surname: "Журавлёв",
  firstname:"Даниил",
  lastname: "Дмитриевич",
  email: "example@mail.com",
  git: "sdfghjk",
  phone_number: "89182188064",
  birthdate: "14/03/2005"

)

igor= Student.new(
  id: "2",
  surname: "Софронов",
  firstname:"Игорь",
  lastname: "Дмитриевич",
  phone_number: "89182188064",
  telegram: "igor",
  git: "gsgsgs",
  email: "example@mail.com",
  birthdate: "08/08/2004"
)


puts dan
puts igor
puts dan.birthdate
puts igor.birthdate

puts dan.birthdate > igor.birthdate

tree = BinaryTree.new
tree.add(dan)
tree.add(igor)

tree.iterator.each do |node|
	puts node.firstname
end

dan_short=Student_short.from_string(id: dan.id, string: dan.get_info)
puts "#4:"
data_table = Data_table.new([[]])

data_list = Data_list_student_short.new([dan_short])

data_list.get_data
puts data_list.row_from_attrs(dan_short)
data_list.select(0)
result =  data_list.get_data.get_by_index(0, 1)
puts result

sl = Student_list.new 
sl.strategy = YAML_strategy.new('students_list.yaml')
sl.insert_student(dan)

temp = sl.get_k_n_student_short_list(1, 2)
temp.select(1)
puts temp.get_data.count_of_rows