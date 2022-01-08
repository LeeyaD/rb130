# The Range#step method lets you iterate over a range of values where each value in the iteration is the previous value plus a "step" value. It returns the original range.

# Write a method that does the same thing as Range#step, but does not operate on a range. Instead, your method should take 3 arguments: the starting value, the ending value, and the step value to be applied to each iteration. Your method should also take a block to which it will yield (or call) successive iteration values.

# What do you think would be a good return value for this method, and why?
# A Range object because that's what the original method returned

=begin
PROBLEM
Creating our own Range#step method but ours takes 3 arguments; starting value, ending value, and step value.
Starting with the starting value, we yield with it to the given block. Upon it's return from the block, we add the step value creating a new value to yield to the block. We continue doing this until we reach our ending value. Then, we return a Range object created with the original starting & ending values.

input; 3 args - starting value, ending value, step value
- starting value: the first value to be passed to the block
- ending value: the value we stop at
- step value: the value we increment with

output: whatever is specified by the block

Notes/Questions:
- Deciding to return a Range object with the starting & ending values because the original Range#step does this
? How to handle bad input? raise an error? have default values?

DS: integers
ALGO
- create a method that takes 3 arguements; starting, ending, and step value and a block
- raise error if starting value is higher than ending value, "Starting value cannot be higher than Ending value"
- initialize a value var to the starting value
- create a loop
- yield to the block with the value var
- after returning from block, increment value by the step value
- if value is equal to and/or more than our ending value, break loop
- return Range object using starting & ending value
=end

def step (starting_value, ending_value, step_value)
  if starting_value > ending_value
    raise RangeError, "Starting value cannot be higher than Ending value"
  end

  value = starting_value
  until value > ending_value
    yield(value)
    value += step_value
  end

  # return Range.new(starting_value, ending_value)  X
  return value                                   #  O
end

p step(1, 10, 3) { |value| puts "value = #{value}" }
p step(11, 10, 3) { |value| puts "value = #{value}" }

# value = 1
# value = 4
# value = 7
# value = 10

# LS's chosen return value:
# Choose to return `current_value` simply cause it's a reasonably sensible value. Range#step returns self (this is, the original Range object), but that doesn't work for us. Another reasonable return value might be nil, or perhaps the last value returned by the block.