require_relative 'block'

a = 4
b = 10
array = get_array_from_input

loop do
    puts "\nВыберите действие:"
    puts "1 - Дан целочисленный массив. Необходимо найти элементы, расположенные перед последним минимальным."
    puts "2 - Дан целочисленный массив. Необходимо найти элементы, расположенные после первого максимального."
    puts "3 - Дан целочисленный массив. Проверить, чередуются ли в нем положительные и отрицательные числа."
    puts "4 - Дан целочисленный массив и интервал a..b. Необходимо найти сумму элементов, значение которых попадает в этот интервал."
    puts "5 - Для введенного списка найти количество таких элементов, которые больше, чем сумма всех предыдущих"
    puts "6 - Выход"
    choice = STDIN.gets.chomp
  
    case choice
    when '1'
        puts elements_before_last_min(array)
    when '2'
        puts elements_after_first_max(array)
    when '3'
        puts alternating_signs?(array)
    when '4'         
        puts sum_in_interval(array, a, b)
    when '5'
        puts count_greater_than_sum(array)
    when '6'
      puts "Выход из программы."
      break
    else
      puts "Неверный ввод. Пожалуйста, выберите 1, 2, 3, 4, 5."
    end
  end