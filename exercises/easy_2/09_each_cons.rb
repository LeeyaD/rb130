# The Enumerable#each_cons method iterates over the members of a collection taking each sequence of n consecutive elements at a time and passing them to the associated block for processing. It then returns a value of nil.

# Write a method called each_cons that behaves similarly for Arrays, taking the elements 2 at a time. The method should take an Array as an argument, and a block. It should yield each consecutive pair of elements to the block, and return nil.

# Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

=begin
PROBLEM
Create our own #each_cons method that iterates thru a collection and passes each sequence of n consecutive elements at a time to the associated block. And, returns nil

input: an array
output: nil

Notes:
- we can use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate
- we CANNOT use any other method to iterate thru given Array

DS: array
ALGO
- create a method that takes 1 argument, an array, and a block
- SET a constant, at_a_time, to 2
- iterate thru given array, for current element
-- yield to block with 1 argument, the elements in the given array starting w/ the current element for the length of our constant, at_a_time
- return nil
=end

def each_cons(array)
  n = 2
  array.each_with_index do |_, idx|
    break unless array[idx, n].size == n
    yield(array[idx, n])
  end
  return nil
end

hash = {}
result = each_cons([1, 3, 6, 10]) do |value1, value2|
  hash[value1] = value2
end
p result == nil
p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
result = each_cons([]) do |value1, value2|
  hash[value1] = value2
end
p hash == {}
p result == nil

hash = {}
result = each_cons(['a', 'b']) do |value1, value2|
  hash[value1] = value2
end
p hash == {'a' => 'b'}
p result == nil