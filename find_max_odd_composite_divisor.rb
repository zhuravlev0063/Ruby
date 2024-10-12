def process_number(n)
  return "Введите число больше или равное 1." if n < 1

  max_divisor = -1
  proisv = 1

  for divisor in 1..n
    if n % divisor == 0
      # Проверяем, является ли делитель четным
      if divisor % 2 == 0
        product = 1
        num = divisor
        while num > 0
          digit = num % 10
          if digit != 0  # Исключаем ноль из произведения
            product *= digit
          end
          num /= 10
        end
        proisv *= product
      end

      # Проверяем, является ли делитель нечетным и непростым
      if divisor % 2 != 0 && !is_prime(divisor)
        if divisor > max_divisor
          max_divisor = divisor
        end
      end
    end
  end

  if max_divisor == -1
    "Не найдено нечетных непростых делителей."
  else
    result_gcd = gcd(max_divisor, proisv)
    "Максимальный нечетный непростой делитель: #{max_divisor}, " \
    "Произведение цифр: #{proisv}, " \
    "НОД: #{result_gcd}."
  end
end

def is_prime(k)
  return false if k < 2
  for i in 2..(k ** 0.5).to_i  # Используем возведение в степень для получения корня
    return false if k % i == 0
  end
  true
end

def gcd(a, b)
  while b != 0
    a, b = b, a % b
  end
  a
end

puts "Введите число:"
num = gets.chomp.to_i
puts process_number(num)
