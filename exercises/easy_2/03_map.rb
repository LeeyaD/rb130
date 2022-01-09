# The Enumerable#map method iterates over the members of a collection, using the associated block to perform some sort of operation on each collection member. The returned values from the block are then built up into an Array that is then returned to the caller. Note in particular that every time #map yields to the block, it obtains just one value. That value may be a complex value - it may even be another collection - but it is nevertheless just one value. Thus, #map returns an Array that has the same number of elements that the original collection had.

# Write a method called map that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return a new Array that contains the return values produced by the block for each element of the original Array.

# If the Array is empty, map should return an empty Array, regardless of how the block is defined.

# Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.
=begin
PROBLEM
Create our own #map method that behaves similarly to Array#map. Iterating over elements in a collection, passing exactly one element to the block and populating a new array with the block's returned values.

input: 1 argument and a block
- arg is an array
output: a new array
- populated w/ return values from block for each element

Notes:
- if array arg is empty, #map should return an empty Array
- we CAN use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate thru given array
- we CANNOT use any other methods than those specified above

DS: array
ALGO:
- create a method that takes 1 argument and 1 block
- initialize a new array var to an empty array
- iterate thru array, for each element
-- yield w/ curr element as an argument, to the block
-- add block's return value to new array
- return new array
=end

def map(array)
  if array.class == Hash
    array = array.to_a
  end

  # new_array = []
  # array.each { |el| new_array.push(yield(el)) }
  # new_array

  # array.each_with_object([]) { |el, arr| arr.push(yield(el)) }

  new_array = []
  index = 0
  until index >= array.size
    new_array << yield(array[index])
    index += 1
  end
  new_array
end

hash = {"books" => 3, "cars" => 5}
p map(hash) { |_, value| value += 10 } == [13, 15]
p map(hash) { |key,_| key.upcase } == ["BOOKS", "CARS"]

p map([1, 3, 6]) { |value| value**2 } == [1, 9, 36]
p map([]) { |value| true } == []
p map(['a', 'b', 'c', 'd']) { |value| false } == [false, false, false, false]
p map(['a', 'b', 'c', 'd']) { |value| value.upcase } == ['A', 'B', 'C', 'D']
p map([1, 3, 4]) { |value| (1..value).to_a } == [[1], [1, 2, 3], [1, 2, 3, 4]]