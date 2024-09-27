# Функция для поиска минимального элемента
def find_min(arr)
  min = arr[0]  # Инициализируем минимальный элемент первым элементом массива
  for i in 1...arr.length
    min = arr[i] if arr[i] < min
  end
  min
end

# Функция для поиска номера первого положительного элемента
def find_first_positive_index(arr)
  index = 0
  while index < arr.length
    return index if arr[index] > 0
    index += 1
  end
  nil  # Если положительных элементов нет
end

# Функция для поиска первого положительного элемента
def find_first_positive(arr)
  for i in 0...arr.length
    return arr[i] if arr[i] > 0
  end
  nil  # Если положительных элементов нет
end

# Пример массива
arr = [-10, -5, 0, 7, 4, -1]

# Вызываем методы и выводим результаты
puts "Минимальный элемент: #{find_min(arr)}"
first_positive_index = find_first_positive_index(arr)
if first_positive_index
  puts "Номер первого положительного элемента: #{first_positive_index}"
else
  puts "Положительных элементов нет"
end

first_positive = find_first_positive(arr)
if first_positive
  puts "Первый положительный элемент: #{first_positive}"
else
  puts "Положительных элементов нет"
end
