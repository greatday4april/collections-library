require_relative 'bsearch'

"""

"""

# @param {Integer[]} nums
# @param {Integer} target
# @return {Integer[]}
def search_range(nums, target)
  lower_bound = nums.bsearch_low { |ele| ele >= target }
  return [-1, -1] if lower_bound.nil? || (nums[lower_bound] != target)

  [lower_bound, nums.bsearch_high { |ele| ele <= target }]
end

nums = [5, 7, 7, 8, 8, 10]
target = 8
p search_range(nums, target) # [3,4]

nums = [5,7,7,8,8,10]
target = 6
p search_range(nums, target) # [-1, -1]
