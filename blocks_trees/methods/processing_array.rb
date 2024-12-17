class Processing_Array

  attr_reader :array

  def initialize(array)
    self.array = array
  end

  def array=(array)
    if array.is_a? (Array)
      @array = array  
    else
      raise TypeError.new('Неверный тип входных данных')
    end
  end

  private :array, :array=


  def filter
    result = []
    self.array.each { |element| result << element if yield(element) }
    result
  end


  def member?(value)
    self.array.each { |element| return true if element == value }
    false
  end


  def sum
    total = 0
    self.array.each { |element| total += yield(element) }
    total
  end

  def reduce(initial = nil)
    if initial.nil?
      accumulator = self.array.first
      self.array[1..].each { |element| accumulator = yield(accumulator, element) }
    else
      accumulator = initial
      self.array.each { |element| accumulator = yield(accumulator, element) }
    end
    accumulator
  end 



  def include?(value)
    self.array.each { |element| return true if element == value }
    false
  end


  def chunk
    return enum_for(:chunk) unless block_given?
    result = []
    current_key = nil
    current_chunk = []

    self.array.each do |element|
      key = yield(element)
      if key != current_key
        result << [current_key, current_chunk] unless current_chunk.empty?
        current_key = key
        current_chunk = []
      end
      current_chunk << element
    end
    result << [current_key, current_chunk] unless current_chunk.empty?
    result
  end
end


array = [1, 2, 3, 4, 5]
handler = Processing_Array.new(array)


puts handler.filter { |x| x > 2 }.inspect

puts handler.member?(3)

puts handler.sum { |x| x }

puts handler.reduce(0) { |acc, x| acc + x }

puts handler.include?(5)

puts handler.chunk { |x| x.even? }.inspect
