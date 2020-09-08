require 'json'

class MaxHeap
  # Implement a MaxHeap using an array
  def initialize(elements)
    # Initialize arr with nil as first element
    # This dummy element makes it where first real element is at index 1
    # You can now divide i / 2 to find an element's parent
    # Elements' children are at i * 2 && (i * 2) + 1
    non_leaf_end_idx = (elements.length / 2).to_i
    @elements = [nil] + elements
    (1..non_leaf_end_idx).reverse_each do |idx|
      bubble_down(idx)
    end
  end

  def <<(element)
    # push item onto end (bottom) of heap
    @elements.push(element)
    # then bubble it up until it's in the right spot
    bubble_up(@elements.length - 1)
  end

  def pop
    # swap the first and last elements
    @elements[1], @elements[@elements.length - 1] = @elements[@elements.length - 1], @elements[1]
    # Min element is now at end of arr (bottom of heap)
    max = @elements.pop
    # Now bubble the top element (previously the bottom element) down until it's in the correct spot
    bubble_down(1)
    # return the min element
    max
  end

  def inspect
    "Max Heap: #{JSON.generate(@elements[1..-1])}"
  end

  private

  def bubble_up(index)
    parent_i = index / 2
    # Done if you reach top element or parent is already smaller than child
    return if index <= 1 || @elements[parent_i] >= @elements[index]

    # Otherwise, swap parent & child, then continue bubbling
    @elements[parent_i], @elements[index] = @elements[index], @elements[parent_i]

    bubble_up(parent_i)
  end

  def bubble_down(index)
    child_i = index * 2
    return if child_i > @elements.size - 1

    # get largest child
    not_last = child_i < @elements.size - 1
    left = @elements[child_i]
    right = @elements[child_i + 1]
    child_i += 1 if not_last && right > left

    # stop if parent element is already less than children
    return if @elements[index] >= @elements[child_i]

    # otherwise, swap and continue
    @elements[index], @elements[child_i] = @elements[child_i], @elements[index]
    bubble_down(child_i)
  end
end

p MaxHeap.new([2, 3, 100, 56, 12, 24]) if __FILE__ == $PROGRAM_NAME
