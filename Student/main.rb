require_relative 'student'
require_relative 'binary_tree'



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

