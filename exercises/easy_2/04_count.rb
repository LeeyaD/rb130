# The Enumerable#count method iterates over the members of a collection, passing each element to the associated block. It then returns the number of elements for which the block returns a truthy value.

# Write a method called count that behaves similarly for an arbitrarily long list of arguments. It should take 0 or more arguments and a block, and then return the total number of arguments for which the block returns true.

# If the argument list is empty, count should return 0.

# Your method may use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.
=begin
PROBLEM
Create our own #count method that iterates over passed in arguments, passing each one to an associated block.
It should return the number of times for which the block returned a truthy value.

input: 0+ arguments and a block
- argument list length will be 0 or more
output: integer
- the # of times the block returned a truthy value, i.e., not nil nor false

Notes:
- we CAN use #each, #each_with_object, #each_with_index, #inject, loop, for, while, or until
- we CANNOT use any other methods not listed above
- return 0 if no arguments are given

DS: array
ALGO:
- create a method that takes 0+ arguments and a block
- initialize a var to zero
- iterate through array of args, passing each one to the block
--  increment counter var by 1 each time the block returns a truthy value
- return counter variable
=end

def count(*args)
  truthy_count = 0
  args.each { |arg| truthy_count += 1 if yield(arg) }
  truthy_count
end

p count(1, 3, 6) { |value| value.odd? } == 2
p count(1, 3, 6) { |value| value.even? } == 1
p count(1, 3, 6) { |value| value > 6 } == 0
p count(1, 3, 6) { |value| true } == 3
p count() { |value| true } == 0
p count(1, 3, 6) { |value| value - 6 } == 3