# Write a method that takes a sorted array of integers as an argument, and returns an array that includes all of the missing integers (in order) between the first and last elements of the argument.
# 
# Input: sorted array
# Output: an array
# - all the missing numbers (in order) between the first & last elements of the given sorted array
# - no missing numbers? return an empty array
# - one element array? return empty array

# DS: array
# ALGO
# method, that takes a sorted 'array'
# init. 'missing_numbers' array to []
# DETERMINE which numnbers are missing
# - COUNT from first_element in 'array' up to last_element in 'array
# - - for each number, check if it's in the given 'array'
# ----- IF if curr_number is in 'array' ignore
# ----- ELSE add curr_number to 'missing_numbers' array
# RETURN 'missing numbers' array

def missing(array)
  missing_numbers = []
  starting_num = array[0]
  ending_num = array[-1]
  
  starting_num.upto(ending_num) do |number|
    if !array.include?(number)
      missing_numbers << number
    end
  end
  
  missing_numbers
end

p missing([-3, -2, 1, 5]) == [-1, 0, 2, 3, 4]
p missing([1, 2, 3, 4]) == []
p missing([1, 5]) == [2, 3, 4]
p missing([6]) == []