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

begin
puts "Пожалуйста введите команду на языке Ruby"
ruby_command= STDIN.gets.chomp
# Выполняем команду Ruby
res_ruby=eval(ruby_command)
puts "Результат выполнения команды Ruby: #{res_ruby}"
rescue NameError
   puts "Ошибка, такой команды нет"
rescue SyntaxError
   puts "Ошибка в написании команды"
end

puts "Введите команду операционной системы:"
os_command = STDIN.gets.chomp
# Выполняем команду операционной системы
res_os=system(os_command)
if system(os_command)
   puts "Результат выполнения команды ОС: #{res_os}"
else
   puts "Ошибка, такой команды нет"
end