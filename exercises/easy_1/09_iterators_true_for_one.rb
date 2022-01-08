# In the previous 3 exercises, you developed methods called any?, all?, and none? that are similar to the standard Enumerable methods of the same names. In this exercise, you will develop one last method from this family, one?.

# Enumerable#one? processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of true for exactly one element, then #one? returns true. Otherwise, #one? returns false. Note in particular that #one? will stop searching the collection the second time the block returns true.

# Write a method called one? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns true for exactly one of the element values. Otherwise, it should return false.

# Your method should stop processing elements of the Array as soon as the block returns true a second time.

# If the Array is empty, one? should return false, regardless of how the block is defined.

# Your method may not use any standard ruby method that is named all?, any?, none?, or one?.

=begin
PROBLEM
Create our own #one? method that behaves similarly to Array#one? returning true if the block returns true for exactly one element and false otherwise.

input: 1 array and 1 block
output: a boolean object
- true if block returns true for exactly one element
- false if the block never returns true or returns true for more than one element

Notes:
- method should stop processing as soon as block returns true a second time
- if given array is empty, method should return false regardless of how block is defined
- we CANNOT use all?, any?, none?, or one?

DS: array, 
ALGO:
- create a method that takes 1 argument and a block
- initialize a counter to 0
- iterate thru given array, passing each element to the block
-- if the block returns true, increment counter by 1
-- if block returns false, continue to next element in array
-- stop iterating & return false if counter is more than 1
* return true is counter equals 1
- return false
=end

def one?(array)
  counter = 0
  array.each do |el|
    counter += 1 if yield(el)
    return false if counter > 2
  end
  return counter == 1 ? true : false
end

p one?([1, 3, 5, 6]) { |value| value.even? }    # -> true
p one?([1, 3, 5, 7]) { |value| value.odd? }     # -> false
p one?([2, 4, 6, 8]) { |value| value.even? }    # -> false
p one?([1, 3, 5, 7]) { |value| value % 5 == 0 } # -> true
p one?([1, 3, 5, 7]) { |value| true }           # -> false
p one?([1, 3, 5, 7]) { |value| false }          # -> false
p one?([]) { |value| true }                     # -> false