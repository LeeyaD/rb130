# The Enumerable#drop_while method begins by iterating over the members of a collection, passing each element to the associated block until it finds an element for which the block returns false or nil. It then converts the remaining elements of the collection (including the element that resulted in a falsey return) to an Array, and returns the result.

# Write a method called drop_while that behaves similarly for Arrays. It should take an Array as an argument, and a block. It should return all the elements of the Array, except those elements at the beginning of the Array that produce a truthy value when passed to the block.

# If the Array is empty, or if the block returns a truthy value for every element, drop_while should return an empty Array.

# Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.

=begin
PROBLEM
Create our own #drop_while method that iterates through a given collection, passing each element to the associated block. While the block returns a truthy value, i.e., not false or nil, the element should be dropped from the array we're returning at the end. Once the block returns it's first false or nil, that element along with any remaining elements in the collection, should be included in the array we're returning at the end.

input: an array
output: modified array

Notes/Qs:
- return a new array or mutate the given one?
- we CAN use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate over input
- we CANNOT use methods other than the ones listed above
- an empty array returns an empty array
- if the block returns truthy every time, an empty array should be returned

DS: array
ALGO:
- create a method that takes 1 array argument and a block
- initialize a var to an empty array
- initialize a var to false, 'false_value'
- iterate through given array, yield to the block w/ the current element as an argument
-- IF 'false_value' is true, 
---- ADD the current element to our empty array and
---- SKIP to next iteration
-- IF 'false value' is false, check block's return value
---- IF block return is true, skip to next iteration
---- IF block return is false..
------ ADD the current element to our empty array and
------ REASSIGN the 'false_value' variable to true
- RETURN array var
=end

# def drop_while(array)
#   new_array = []
#   false_value = false

#   array.each do |el| 
#     if false_value
#       new_array.push(el)
#       next
#     end

#     next if yield(el)
#     new_array.push(el)
#     false_value = true
#   end
#   new_array
# end

def drop_while(array)
  new_array = []
  false_value = false

  array.each_with_index do |el, idx| 
    if false_value
      new_array.push(el)
      next
    end

    next if yield(el)
    new_array.push(el)
    false_value = true
  end
  new_array
end

def drop_while(array)
 
  false_value = nil

  array.each_with_index do |el, idx| 
    if yield(el) == false
      false_value = idx 
      break
    end
    
  end
  
  false_value ? array[false_value..-1] : []
end

p drop_while([1, 3, 5, 6]) { |value| value.odd? } == [6]
p drop_while([1, 3, 5, 6]) { |value| value.even? } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6, 8, 10]) { |value| value.even? } == [1, 3, 5, 6, 8, 10]
p drop_while([1, 3, 5, 6]) { |value| true } == []
p drop_while([1, 3, 5, 6]) { |value| false } == [1, 3, 5, 6]
p drop_while([1, 3, 5, 6]) { |value| value < 5 } == [5, 6]
p drop_while([]) { |value| true } == []

# LS's solution, better to go manual when I know we don't need to iterate through the entire collection
def drop_while(array)
  index = 0
  while index < array.size && yield(array[index])
    index += 1
  end

  array[index..-1]
end
