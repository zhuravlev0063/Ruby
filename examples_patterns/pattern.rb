class Coffeine_beverage
  def prepare_recipe
    boil_water
    brew
    pour_in_cup
    add_condiments
  end

  def boil_water
    puts "Кипятим воду"
  end

  def brew
    raise NotImplementedError, "Этот метод должен быть переопределен в подклассе"
  end

  def pour_in_cup
    puts "Разливаем напиток по чашкам"
  end

  def add_condiments
    raise NotImplementedError, "Этот метод должен быть переопределен в подклассе"
  end
end

class Coffee < Coffeine_beverage
  def brew
    puts "добавляем кофе через фильтер"
  end

  def add_condiments
    puts "Добавляем сахар и молоко"
  end
end

class Tea < Coffeine_beverage
  def brew
    puts "Завариваем чайный пакетик"
  end

  def add_condiments
    puts "Добавляем лемон"
  end
end

# Использование шаблонного метода
def client_code
  puts "Приготовление кофе:"
  coffee = Coffee.new
  coffee.prepare_recipe

  puts "\nПриготовление чая:"
  tea = Tea.new
  tea.prepare_recipe
end
client_code