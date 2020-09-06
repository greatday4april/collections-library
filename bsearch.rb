class Array
  def bsearch_low(&block)
    low = 0
    high = length
    while low < high
      mid = low + (high - low) / 2
      smaller = block.call(self[mid])
      if smaller
        high = mid
      else
        low = mid + 1
      end
    end
    return nil if self[low].nil? || !block.call(self[low])

    low
  end

  def bsearch_high(&block)
    low = 0
    high = length
    while low < high
      mid = low + (high - low) / 2
      bigger = block.call(self[mid])
      if bigger
        low = mid
      else
        high = mid - 1
      end
    end
    return nil if self[low].nil? || !block.call(self[low])

    low
  end
end

if __FILE__ == $PROGRAM_NAME
  p [1, 2, 3, 4, 5, 6].bsearch_low { |ele| ele == 4 } # 3
  p [1, 2, 3, 4, 5, 6].bsearch_high { |ele| ele == 4 } # 3

  p [1, 2, 4, 4, 4, 5].bsearch_low { |ele| ele == 4 } # 2
  p [1, 2, 4, 4, 4, 5].bsearch_low { |ele| ele > 5 } # nil
  p [1, 2, 4, 4, 4, 5].bsearch_low { |ele| ele >= 3 } # 2

  p [1, 2, 4, 4, 4, 5].bsearch_high { |ele| ele == 4 } # 4
  p [1, 2, 4, 4, 4, 5].bsearch_high { |ele| ele <= 4 } # 4
  p [1, 2, 4, 4, 4, 5].bsearch_high { |ele| ele <= 0 } # nil
  p [1, 2, 4, 4, 4, 5].bsearch_high { |ele| ele > 5 } # nil
end
