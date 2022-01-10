# The Enumerable#each_with_object method iterates over the members of a collection, passing each element and an arbitrary object (usually a collection) to the associated block. The value returned by the block is not used. The object that is passed to the block is defined as an argument to each_with_object; with each iteration, this object may be updated by the block. When iteration is complete, the final value of the object is returned.

# Write a method called each_with_object that behaves similarly for Arrays. It should take an Array and an object of some sort as an argument, and a block. It should yield each element and the object to the block. each_with_object should return the final value of the object.

# If the Array is empty, each_with_object should return the original object passed as its second argument.

# Your method may use #each, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

=begin
PROBLEM
Create our own #each_with_object method that iterates over a collection, passing each element and an object to an associated block. Block's return value isn't used. The object passed to the block is defined as an arg to #each_with_object. Method returns the value of the object.

input: 2 arguments, an array & an object, and a block
- array, what we're iterating over
- object, usually a collection
output: the object

Notes:
- we can use #each, #each_with_index, #inject, loop, for, while, or until to iterate
- we CANNOT use any other methods to iterate thru the Array or any other collection
- if given array is empty, we should return the original object being passed in as the 2nd arg

DS: array

ALGO
- create a method that takes 2 arguments, an array & an object, and a block
- iterate thru given array, for each element
-- yield to the block with 2 arguments; the current element & the given object
- return object
=end

def each_with_object(array, object)
  array.each do |el|
    yield(el, object)
  end
  object
end

result = each_with_object([1, 3, 5], []) do |value, list|
  list << value**2
end
p result == [1, 9, 25]

result = each_with_object([1, 3, 5], []) do |value, list|
  list << (1..value).to_a
end
p result == [[1], [1, 2, 3], [1, 2, 3, 4, 5]]

result = each_with_object([1, 3, 5], {}) do |value, hash|
  hash[value] = value**2
end
p result == { 1 => 1, 3 => 9, 5 => 25 }

result = each_with_object([], {}) do |value, hash|
  hash[value] = value * 2
end
p result == {}