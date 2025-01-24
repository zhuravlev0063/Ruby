require 'minitest/autorun'
require_relative 'processing_array'

class TestProcessing_Array < Minitest::Test

  def test_filter
    proc_array = Processing_Array.new([1, 2, 3, 4, 5])
    assert_equal([2, 4], proc_array.filter { |x| x.even? })
    assert_equal([1, 3, 5], proc_array.filter { |x| x.odd? })
  end

  def test_member?
    proc_array = Processing_Array.new([1, 2, 3])
    assert(proc_array.member?(2))
    refute(proc_array.member?(4))
  end

  def test_sum
    proc_array = Processing_Array.new([1, 2, 3, 4])
    assert_equal(10, proc_array.sum { |x| x })
    assert_equal(20, proc_array.sum { |x| x * 2 })
  end

  def test_reduce
    proc_array = Processing_Array.new([1, 2, 3, 4])
    assert_equal(10, proc_array.reduce { |acc, x| acc + x })
    assert_equal(24, proc_array.reduce(1) { |acc, x| acc * x })
  end

  def test_include?
    proc_array = Processing_Array.new(['a', 'b', 'c'])
    assert(proc_array.include?('a'))
    refute(proc_array.include?('d'))
  end

  def test_chunk
    proc_array = Processing_Array.new([1, 1, 2, 2, 3, 3, 3])
    expected = [[1, [1, 1]], [2, [2, 2]], [3, [3, 3, 3]]]
    assert_equal(expected, proc_array.chunk { |x| x })
  end
end
