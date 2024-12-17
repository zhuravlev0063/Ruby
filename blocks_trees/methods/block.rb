
def elements_before_last_min(array)
  last_min_index = array.rindex(array.min)
  array[0...last_min_index]
end

def elements_after_first_max(array)
  first_max_index = array.index(array.max)
  array[(first_max_index + 1)..-1]
end

def alternating_signs?(array)
  return true if array.empty? || array.length == 1
  array.each_cons(2).all? { |a, b| (a.positive? && b.negative?) || (a.negative? && b.positive?) }
end

def sum_in_interval(array, a, b)
  array.select { |x| x >= a && x <= b }.sum
end

def count_greater_than_sum(array)
  sum, count = array.reduce([0, 0]) do |(sum, count), x|
    if x > sum
      new_count = count + 1
    else
      new_count = count
    end
    [sum + x, new_count]
  end
  count 
end


def get_array_from_input
 puts "1 - Чтение массива из файла"
 puts "2 - Ввод массива с клавиатуры"
 input = STDIN.gets.chomp

 if input == '1'
   puts "Введите имя файла:"
   filename = gets.chomp
   array = File.readlines(filename).map(&:to_i)
   print array.join(' ') + "\n"
 elsif input == '2'
   puts "Введите числа через пробел:"
   array = gets.chomp.split.map(&:to_i)
 else
   puts "Неверный ввод. Пожалуйста, выберите 1 или 2."
 end
 array 
end