# The Enumerable#max_by method iterates over the members of a collection, passing each element to the associated block. It then returns the element for which the block returned the largest value.

# Write a method called max_by that behaves similarly for Arrays. It should take an Array and a block, and return the element that contains the largest value.

# If the Array is empty, max_by should return nil.

# Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

=begin
PROBLEM
Create our own #max_by method that iterates thru a collection, passing each element to the associated block. It returns the element for which the block returned the largest value.

input: 1 argument, an array, and 1 block
output: array element for which the block returned the largest value

Notes:
- use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate
- we CANNOT use any other methods to iterate over the given Array nor any other collections
- if given Array is empty, method should return nil

DS: array
ALGO
- create a method that takes one arg, an array, and a block
- SET a variable to an empty results hash
- iterate thru given array, for each element
-- yield to block with current element as an argument
-- SAVE index & block's return value to results hash
- when iteration ends, sort the values in the results hash
- using the last value in sorted value array, return the corresponding key
- return the array element using the returned hash key as elemental reference
=end

def max_by(array)
  return nil if array.empty?
  results = {}
  array.each_with_index do |el, idx|
    results[idx] = yield(el)
  end
  sorted_values = results.values.sort
  sorted_values
  array[results.key(sorted_values[-1])]
end

# LS's solution, Running Champion!

def max_by(array)
  return nil if array.empty?

  max_element = array.first
  largest = yield(max_element)

  array[1..-1].each do |item|
    yielded_value = yield(item)
    if largest < yielded_value
      largest = yielded_value
      max_element = item
    end
  end

  max_element
end

p max_by([1, 5, 3]) { |value| value + 2 } == 5
p max_by([1, 5, 3]) { |value| 9 - value } == 1
p max_by([1, 5, 3]) { |value| (96 - value).chr } == 1
p max_by([[1, 2], [3, 4, 5], [6]]) { |value| value.size } == [3, 4, 5]
p max_by([-7]) { |value| value * 3 } == -7
p max_by([]) { |value| value + 5 } == nil