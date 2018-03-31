require 'minitest/autorun'
require_relative 'range_calculator'

module SdetTest
  class RangeCalculatorTest < MiniTest::Test
    def setup
      @range_calculator = RangeCalculator.new
    end

    def test_range_calculator_simple
      actual = @range_calculator.calculate_range(1, 10, [3, 5, 7])
      expected = %w[1-2 4 6 8-10]
      assert_equal(expected, actual)
    end

    def test_range_calculator_border
      actual = @range_calculator.calculate_range(1, 10, [1, 2, 5, 6, 8, 9, 10])
      expected = %w[3-4 7]
      assert_equal(expected, actual)
    end

    def test_range_calculator_all_excluded
      actual = @range_calculator.calculate_range(1, 10, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
      expected = []
      assert_equal(expected, actual)
    end

    def test_range_calculator_exclusions_outside_range
      actual = @range_calculator.calculate_range(1, 10, [1, 3, 20, 62, 45])
      expected = %w[2 4-10]
      assert_equal(expected, actual)
    end

    def test_range_calculator_small
      actual = @range_calculator.calculate_range(1, 1, [])
      expected = %w[1]
      assert_equal(expected, actual)
    end

    def test_range_calculator_no_exclusions
      actual = @range_calculator.calculate_range(1, 30, [])
      expected = %w[1-30]
      assert_equal(expected, actual)
    end

    def test_range_calculator_exclusions_out_of_order
      actual = @range_calculator.calculate_range(1, 10, [5, 2, 10, 8])
      expected = %w[1 3-4 6-7 9]
      assert_equal(expected, actual)
    end

    def test_range_calculator_large
      actual = @range_calculator.calculate_range(1, 1_000_000, [22, 34, 2000, 70_000])
      expected = %w[1-21 23-33 35-1999 2001-69999 70001-1000000]
      assert_equal(expected, actual)
    end

    def test_range_calculator_start_greater_than_end
      assert_raises do
        @range_calculator.calculate_range(1, -1, [2, 3])
      end
    end

    # New unit test: Positive test case
    def test_range_calculator_start_negative_integer
      actual = @range_calculator.calculate_range(-10, 7, [-4, 1, 5, 7])
      expected = %w[-10--5 -3-0 2-4 6]
      assert_equal(expected, actual)
    end

    # New unit test: Negative test case
    def test_range_calculator_non_integers_in_exclusion
      assert_raises TypeError do
        @range_calculator.calculate_range(1, 10, ['3', '5', '7'])
      end
    end
  end
end
