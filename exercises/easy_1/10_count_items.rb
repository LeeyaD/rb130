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

def count(array)
  true_count = 0
  array.each { |el| true_count += 1 if yield(el) }
  true_count
end

p count([1,2,3,4,5]) { |value| value.odd? } == 3
p count([1,2,3,4,5]) { |value| value % 3 == 1 } == 2
p count([1,2,3,4,5]) { |value| true } == 5
p count([1,2,3,4,5]) { |value| false } == 0
p count([]) { |value| value.even? } == 0
p count(%w(Four score and seven)) { |value| value.size == 5 } == 2