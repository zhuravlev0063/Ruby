class Context

  attr_writer :strategy

  def initialize(strategy)
    set_strategy(strategy)
  end

  def set_strategy(strategy)
    @strategy = strategy
  end

  def execute_strategy
    @strategy.sum
  end

end

class Strategy

  def sum(data)
    raise NotImplementedError, "#{self.class} не переопределяет метод '#{__method__}'"
  end

end


class Integers < Strategy

  attr_accessor :int1, :int2

  def initialize(int1, int2)
    self.int1 = int1
    self.int2 = int2
  end

  def sum
    return self.int1 + self.int2
  end

end

class Strings < Strategy

  attr_accessor :string1, :string2

  def initialize(string1, string2)
    self.string1 = string1
    self.string2 = string2
  end

  def sum
    return self.string1 + self.string2
  end

end

class Arrays < Strategy

  attr_accessor :array1, :array2

  def initialize(array1, array2)
    self.array1 = array1
    self.array2 = array2
  end

  def sum
    return array1.zip(array2).map { |a, b| a + b }
  end

end

def main
  client = Context.new(Integers.new(1, 5))
  p client.execute_strategy

  client = Context.new(Strings.new(1, 5))
  p client.execute_strategy

  client = Context.new(Arrays.new([1, 5], [6, -5]))
  p client.execute_strategy

end

main