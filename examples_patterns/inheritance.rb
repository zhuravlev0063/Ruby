class Animal
  
  def initialize(name)
    @name = name
  end

  def speak
    "Я животное и меня зовут #{@name}."
  end
end

class Dog < Animal
  def speak
    super + " Гав-гав!"
  end
end

class Cat < Animal
  def speak
    super + " Мяу!"
  end
end

dog = Dog.new("Шарик")
cat = Cat.new("Мурка")

puts dog.speak  
puts cat.speak  