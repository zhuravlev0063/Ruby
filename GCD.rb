require 'prime'

# Функция для поиска максимального нечетного непростого делителя
def max_odd_composite_divisor(n)
  max_divisor = -1

  # Перебираем все возможные делители от 1 до n
  (1..n).each do |divisor|
    if n % divisor == 0 && divisor.odd? && !Prime.prime?(divisor)
      max_divisor = divisor
    end
  end

  max_divisor
end

# Функция для вычисления произведения цифр числа
def product_of_digits(n)
  n.to_s.chars.map(&:to_i).inject(1) { |product, digit| product * digit }
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
product_digits = product_of_digits(num)

if max_divisor == -1
  puts "Не найдено нечетных непростых делителей."
else
  # Вычисляем НОД
  result_gcd = gcd(max_divisor, product_digits)
  puts "Максимальный нечетный непростой делитель: #{max_divisor}"
  puts "Произведение цифр: #{product_digits}"
  puts "НОД: #{result_gcd}"
end
