name= ARGV[0]  # gets считывает ввод, chomp убирает символ новой строки (\n)
puts "Привет, #{name}!"
puts "Какой язык программирования твой самый любимый?"
lang= STDIN.gets.chomp

case lang
  when "ruby"
     puts "Не подлизывайся"
  when "python"
     puts "скучно"
  when "java"
     puts "хороший выбор"
  when "c++"
     puts "оригинально"
  else
      puts "Значит скоро станет любимым Ruby"
end


puts "Пожалуйста введите команду на языке Ruby"
ruby_command= STDIN.gets.chomp

# Выполняем команду Ruby
puts "Результат выполнения команды Ruby:"
eval(ruby_command)



puts "Введите команду операционной системы:"
os_command = STDIN.gets.chomp

# Выполняем команду операционной системы
puts "Результат выполнения команды ОС:"
system(os_command)