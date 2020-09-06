class Array
  ''"
  condition should be a function that evaluates as
  [False, False ... True, True, True], aka >= target
  "''
  def bsearch_low(&block)
    low = 0
    high = length
    while low < high
      mid = low + (high - low) / 2 # closer to low
      smaller = block.call(self[mid])
      # keep this upper-bound while trying lower upper-bound
      if smaller
        high = mid
      else
        low = mid + 1
      end
    end
    return nil if self[low].nil? || !block.call(self[low])

    low
  end

  ''"
  condition should be a function that evaluates as
  [True, True ... False, False, False], aka <= target
  "''
  def bsearch_high(&block)
    low = 0
    high = length
    while low < high
      mid = high - (high - low) / 2 # closer to high
      break if self[mid].nil?

      bigger = block.call(self[mid])
      # keep this lower-bound while trying higher lower-bound
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
  p [].bsearch_low { |ele| ele >= 2 } # nil
  p [].bsearch_high { |ele| ele >= 2 } # nil
  p [1].bsearch_low { |ele| ele >= 2 } # nil
  p [1].bsearch_high { |ele| ele <= 0 } # nil

  p [1].bsearch_low { |ele| ele >= 1 } # 0
  p [1].bsearch_high { |ele| ele <= 1 } # 0

  p [1, 3].bsearch_low { |ele| ele >= 1 } # 0
  p [1, 3].bsearch_high { |ele| ele <= 1 } # 0

  p [1, 2, 3, 4, 5, 6].bsearch_low { |ele| ele >= 4 } # 3
  p [1, 2, 3, 4, 5, 6].bsearch_high { |ele| ele <= 4 } # 3

  p [1, 2, 4, 4, 4, 5].bsearch_low { |ele| ele >= 4 } # 2
  p [1, 2, 4, 4, 4, 5].bsearch_low { |ele| ele > 5 } # nil
  p [1, 2, 4, 4, 4, 5].bsearch_low { |ele| ele >= 3 } # 2

  p [1, 2, 4, 4, 4, 5].bsearch_high { |ele| ele <= 4 } # 4
  p [1, 2, 4, 4, 4, 5].bsearch_high { |ele| ele <= 0 } # nil
  p [1, 2, 4, 4, 4, 5].bsearch_high { |ele| ele < 5 } # 4

end
