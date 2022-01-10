# The Enumerable#each_with_index method iterates over the members of a collection, passing each element and its index to the associated block. The value returned by the block is not used. each_with_index returns a reference to the original collection.

# Write a method called each_with_index that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should yield each element and an index number to the block. each_with_index should return a reference to the original Array.

# Your method may use #each, #each_with_object, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

=begin

UNDERSTANDING THE PROBLEM
Create our own #each_with_index method that iterates over a collection, passing each element and an index to the block. Block's return value is NOT used. Our method must return a reference to the original collection.

input: 1 array and a block
output: reference to original array

Notes:
- we can use #each, #each_with_object, #inject, loop, for, while, or until to iterate
- we CANNOT use any other iterating methods
- block's return value is not used
******************************************************************************

EXAMPLES AND TEST CASES


******************************************************************************

DATA STRUCTURES
array
******************************************************************************

HINTS/AND QUESTIONS

******************************************************************************

ALGORITHM
- create a method that takes 1 argument, an array, and 1 block
- initialize a variable to 0, index
- iterate thru given array, for each element
--- yield to block w/ 2 arguments; the curr_element and 'index'
--- increment index by 1
- return given array

******************************************************************************


=end

# CODE
def each_with_index(array)
  index = 0
  
  # array.each do |el| 
  #   yield(el, index)
  #   index += 1
  # end
  
  while index < array.size
    yield(array[index], index)
    index += 1
  end
  
#   until index >= array.size
#     yield(array[index], index)
#     index += 1
#   end
  
  
  # loop do
  #   yield(array[index], index)
  #   index += 1
  #   break if index >= array.size
  # end
  
  array
end