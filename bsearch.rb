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
