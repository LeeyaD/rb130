# In the previous exercise, you developed a method called any? that is similar to the standard Enumerable#any? method for Arrays (our actual solution works with any Enumerable collection). In this exercise, you will develop its companion, all?.

# Enumerable#all? processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of true for every element, then #all? returns true. Otherwise, #all? returns false. Note in particular that #all? will stop searching the collection the first time the block returns false.

# Write a method called all? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns true for all of the element values. Otherwise, it should return false.

# Your method should stop processing elements of the Array as soon as the block returns false.

# If the Array is empty, all? should return true, regardless of how the block is defined.

# Your method may not use any standard ruby method that is named all?, any?, none?, or one?.
=begin
PROBLEM
Create our own #all? method that behaves similarly to Array#all? Returning true if the block returns true for every element and false otherwise.

input: 1 arg an array and 1 block
output: a boolean object
- true if the block returns true for every element passed to it
- false if the block never returns

Notes:
- method should stop iterating as soon as the block returns false
- if the Array is empty, all? should return true regardless of how the block is defined.
- we CANNOT use all?, any?, none?, or one?

DS: array
ALGO:
- create a method that takes one 1 argument and a block
- iterate thru given array, passing each element to the block
-- if block returns false, stop iterating & return false from method
-- if block returns true, continue iterating thru collection
- if block never returns false & iteration ends, return true
=end

def all?(array)
  array.each {|el| return false if yield(el) == false}
  return true
end

p all?([1, 3, 5, 6]) { |value| value.odd? } == false
p all?([1, 3, 5, 7]) { |value| value.odd? } == true
p all?([2, 4, 6, 8]) { |value| value.even? } == true
p all?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p all?([1, 3, 5, 7]) { |value| true } == true
p all?([1, 3, 5, 7]) { |value| false } == false
p all?([]) { |value| false } == true