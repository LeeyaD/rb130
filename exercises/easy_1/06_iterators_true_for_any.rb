# A great way to learn about blocks is to implement some of the core ruby methods that use blocks using your own code. Over this exercise and the next several exercises, we will do this for a variety of different standard methods.

# The Enumerable#any? method processes elements in a collection by passing each element value to a block that is provided in the method call. If the block returns a value of true for any element, then #any? returns true. Otherwise, #any? returns false. Note in particular that #any? will stop searching the collection the first time the block returns true.
  
# Write a method called any? that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return true if the block returns true for any of the element values. Otherwise, it should return false.
  
# Your method should stop processing elements of the Array as soon as the block returns true.
  
# If the Array is empty, any? should return false, regardless of how the block is defined.
  
# Your method may not use any standard ruby method that is named all?, any?, none?, or one?.

=begin
PROBLEM
Create the #any? method that behaves similarly to Array#any? The passed in array will be iterated over and each element passed to the block. The return value of the block on each iteration will determine if our #any? returns true or false. If the block returns a value of true for any element, then #any? returns true. Otherwise, #any? returns false.

input: 1 argument, 'array' & 1 block
- block will be the criteria for when #any? returns true

output: a boolean object, true or false
- true if the block returns true
- false if the block never returns true

Notes:
- #any? should stop iterating over the collection the first time the block returns true
- if the Array is empty, #any? should return false, regardless of how the block is defined
- we cannot use all?, any?, none?, or one?

Questions:
- How to handle an Array that contains non-integer values?
-- raise error? Hmm..I thnk it'll be handled by block code

DS: 
-array

ALGO:
- create a method that takes 1 arg & a block
- iterate through given array, passing each element to the block
- capture the return value of the block
-- if the return value is true, stop iterating & return true from the method
-- if the return value is false, continue iterating through the method
- if iteration finishes and we're still in the method (i.e. the block never returned true), return false
=end

def any?(array)
  array.each do |el|
    block_return = yield(el)
    return true if block_return == true
  end

  return false
end

p any?([1, 3, 5, 6]) { |value| value.even? } == true
p any?([1, 3, 5, 7]) { |value| value.even? } == false
p any?([2, 4, 6, 8]) { |value| value.odd? } == false
p any?([1, 3, 5, 7]) { |value| value % 5 == 0 } == true
p any?([1, 3, 5, 7]) { |value| true } == true
p any?([1, 3, 5, 7]) { |value| false } == false
p any?([]) { |value| true } == false