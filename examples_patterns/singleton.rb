class ManualSingleton
  @instance = nil

  def self.instance
    @instance ||= new
  end

  private_class_method :new  # Запрещаем создание через new

  def greet
    "Hello from Manual Singleton!"
  end
end

singleton1 = ManualSingleton.instance
singleton2 = ManualSingleton.instance

puts singleton1.greet  # "Hello from Manual Singleton!"
puts singleton1.object_id == singleton2.object_id  # true
