# Функция для проверки, является ли число простым
def is_prime?(n)
  return false if n < 2
  (2..Math.sqrt(n).to_i).each do |i|
    return false if n % i == 0
  end
  true
end

# Функция для поиска максимального нечетного непростого делителя
def max_odd_composite_divisor(n)
  max_divisor = -1

  # Перебираем все возможные делители от 1 до n
  (1..n).each do |divisor|
    if n % divisor == 0 && divisor % 2 != 0 && !is_prime?(divisor)
      max_divisor = divisor
    end
  end

  max_divisor
end

# Функция для вычисления произведения цифр числа
def proisv_of_digits(n)
  proisv = 1
  n.to_s.each_char do |digit|
    proisv *= digit.to_i
  end
  proisv
end

# Функция для вычисления НОД (алгоритм Евклида)
def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

# Основная программа
puts "Введите число:"
num = gets.chomp.to_i

# Находим максимальный нечетный непростой делитель
max_divisor = max_odd_composite_divisor(num)

# Находим произведение цифр числа
proisv_digits = proisv_of_digits(num)

if max_divisor == -1
  puts "Не найдено нечетных непростых делителей."
else
  # Вычисляем НОД
  result_gcd = gcd(max_divisor, proisv_digits)
  puts "Максимальный нечетный непростой делитель: #{max_divisor}"
  puts "Произведение цифр: #{proisv_digits}"
  puts "НОД: #{result_gcd}"
end
  