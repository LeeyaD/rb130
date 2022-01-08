# Write a method that takes an array as an argument, and a block that returns true or false depending on the value of the array element passed to it. The method should return a count of the number of times the block returns true.

# You may not use Array#count or Enumerable#count in your solution.
=begin
PROBLEM
Creating a method that takes an array and a block and counts the number of times our block returns true. Returning that number.

input: 1 array arg & a block
- how to handle bad input? raise an error?
output: an integer
- the number of times the block returned true

Notes:
- we CANNOT use Array#count not Enumerable#count in our algo
- an empty array returns zero

DS: array
ALGO:
- create a method that takes 1 arg, an array, and a block
- initialize a counter to zero
- iterate thru given array, yielding each passing element to the block
-- if the block returns true, increment the counter by 1
-- if the block returns false, iterate to next element in array
- return counter
=end

# def count(array)
#   true_count = 0
#   array.each { |el| true_count += 1 if yield(el) }
#   true_count
# end
=begin
Further Exploration
Write a version of the count method that meets the conditions of this exercise, but also does not use each, loop, while, or until.

ALGO:
- create a method that takes 1 arg, an array, and a block
- initialize variable to size of array minus 1
- initialize a counter to zero
- counting up from zero, using the count & elemental reference
-- yield each array element to the block
-- if the block returns true, increment the counter by 1
-- if the block returns false, iterate to next element in array
- return counter

=end

def count(array)
  size = array.size - 1
  true_count = 0
  0.upto(size) { |num| true_count += 1 if yield(array[num]) }
  true_count
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2