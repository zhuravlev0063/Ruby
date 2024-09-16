def max_prime_divisor(n)
  max_prime = -1

  # Убираем все факторы двойки
  while n % 2 == 0
    max_prime = 2
    n /= 2
  end

  # Проверяем все нечетные числа начиная с 3
  divisor = 3
  while divisor * divisor <= n
    while n % divisor == 0
      max_prime = divisor
      n /= divisor
    end
    divisor += 2
  end

  # Если осталось число больше 2, оно тоже простое
  max_prime = n if n > 2

  max_prime
end

# Пример использования
puts "Введите число:"
num = gets.chomp.to_i
puts "Максимальный простой делитель числа #{num}: #{max_prime_divisor(num)}"
