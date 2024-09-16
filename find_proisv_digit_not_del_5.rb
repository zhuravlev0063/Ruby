def proisv_digit_not_del_5(n)
  digits = n.to_s.chars.map(&:to_i)  # Преобразуем число в массив его цифр
  result = 1  # Начальное значение произведения

  digits.each do |digit|
    # Если цифра не делится на 5, умножаем на неё результат
    result *= digit if digit % 5 != 0
  end

  # Если не нашлось ни одной цифры, которая не делится на 5, вернуть 1
  result
end

# Пример использования
puts "Введите число:"
num = gets.chomp.to_i
puts "Произведение цифр числа #{num}, не делящихся на 5: #{proisv_digit_not_del_5(num)}"