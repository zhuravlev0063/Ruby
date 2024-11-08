# Метод для нахождения минимального элемента
def find_min(arr)
  min = arr[0]
  for i in 1...arr.length
    min = arr[i] if arr[i] < min
  end
  min
end

# Метод для нахождения индекса первого положительного элемента
def find_first_positive_index(arr)
  index = 0
  while index < arr.length
    return index if arr[index] > 0
    index += 1
  end
  nil  # Если положительных элементов нет
end

# Метод для нахождения первого положительного элемента
def find_first_positive(arr)
  for i in 0...arr.length
    return arr[i] if arr[i] > 0
  end
  nil  # Если положительных элементов нет
end

# Основная программа
if ARGV.length != 2
  puts "Использование: ruby program.rb <метод (1/2/3)> <путь к файлу>"
  exit
end

# Принимаем аргументы
method_choice = ARGV[0].to_i  # Первый аргумент — выбор метода (1/2/3)
file_path = ARGV[1]           # Второй аргумент — путь к файлу

# Считываем массив из файла
begin
  arr = File.read(file_path).split.map(&:to_i)  # Чтение файла и преобразование в массив чисел
rescue
  puts "Ошибка при чтении файла!"
  exit
end

# Выбор метода на основе аргумента
case method_choice
when 1
  # Вызов метода для нахождения минимального элемента
  result_1 = find_min(arr)
  puts "Минимальный элемент: #{result_1}"

when 2
  # Вызов метода для нахождения индекса первого положительного элемента
  result_2 = find_first_positive_index(arr)
  if result_2
    puts "Номер первого положительного элемента: #{result_2}"
  else
    puts "Положительных элементов нет"
  end

when 3
  # Вызов метода для нахождения первого положительного элемента
  result_3 = find_first_positive(arr)
  if result_3
    puts "Первый положительный элемент: #{result_3}"
  else
    puts "Положительных элементов нет"
  end

else
  puts "Неверный выбор метода. Используйте 1, 2 или 3."
end
