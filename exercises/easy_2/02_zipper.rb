# The Array#zip method takes two arrays, and combines them into a single array in which each element is a two-element array where the first element is a value from one array, and the second element is a value from the second array, in order. For example:

[1, 2, 3].zip([4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]

# Write your own version of zip that does the same type of operation. It should take two Arrays as arguments, and return a new Array (the original Arrays should not be changed). Do not use the built-in Array#zip method. You may assume that both input arrays have the same number of elements.

=begin
PROBLEM
Create our own Array#zip method that takes 2 arrays and combines them into a new array of sub-arrays. Each sub-array has 2 elements, the first is the value from one array and the second if the value from the second array, in order.

input: 2 arrays of equal length
output: a new array with given arrays 'zipped'

Notes:
- 'zipped' the new array contains 2-element sub-arrays where:
-- the 1st element is the 1st element from the first array, the 2nd element is the 1st one from the second array
-- the sub-arrays should be in order; i.e., the first sub-array contains first elements, the 2nd sub-array 2nd elements, and so on
- two original arrays should not be changed
- we CANNOT use Array#zip
- can assume both given arrays have the same number of elements

DS: array
ALGO
- create a method that takes two array arguements
- initialize an empty results array
- iterate thru first array with an index, 
-- push an array of the current element from the calling array and the first element from the 2nd given array (using elemental reference) onto our results array
- return results array
=end

def zip(array1, array2)
  results = []
  array1.each_with_index do |el, idx|
    results.push([el, array2[idx]])
  end
  results
end

p zip([1, 2, 3], [4, 5, 6]) == [[1, 4], [2, 5], [3, 6]]
p zip([1, "cat", 3], ["apple", 5, 6]) == [[1, "apple"], ["cat", 5], [3, 6]]