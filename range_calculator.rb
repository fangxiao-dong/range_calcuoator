module SdetTest
  class RangeCalculator
    def calculate_range(range_start, range_end, exclusion_list)
      raise StandardError if range_start > range_end
      raise TypeError, "All exclusion list elements must be Integer!" if (!exclusion_list.empty? && !exclusion_list.all? {|i| i.is_a? Integer})
      results = []
      return results << print_range(range_start, range_end) if exclusion_list.empty?

      # Sort exclusion list in place.
      # Time complexity on average: O(nlogn)
      exclusion_list.sort!
      return result << print_range(range_start, range_end) if (range_end < exclusion_list[0] || range_start > exclusion_list[-1])
      range_array = (range_start..range_end).to_a

      # array to inclue elements in range_array but not in exclusion list
      # Time complexity on average: O(nlogn)
      diff_array = range_array - exclusion_list

      # array to store the index of diff_array where elements break continuity
      # Time complexity on average: O(n)
      index_array = []
      diff_array.each_index { |index|
        index_array << index + 1 if (index < diff_array.length - 1) && (diff_array[index + 1] - diff_array[index] > 1)
      }

      # push appropriate ranges to the results based on the value of element in both diff_array and in indx_array
      # Time complexity on average: O(n)
      index_array.each_with_index { |value, index|
        index == 0 ? results << print_range(diff_array[0], diff_array[value - 1]) : results << print_range(diff_array[index_array[index - 1]], diff_array[value - 1])
        results << print_range(diff_array[value], diff_array[diff_array.length - 1]) if index == index_array.length - 1
      }

      # return results
      # Total time complexity on average: ~O(nlogn)
      results
    end

    private
    # Description: private helper function to print out the range.
    # Params:
    #  - start_range: the starting value from which the range starts
    #  - end_range: the ending value at which the range ends
    # Return: return string representation of the range.
    def print_range(start_range, end_range)
      start_range == end_range ? "#{start_range}" : "#{start_range}-#{end_range}"
    end
  end
end
