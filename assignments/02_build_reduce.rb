# def reduce(array, accumulator=0)
#   array.each do |num|
#     accumulator = yield(accumulator, num)
#   end

#   accumulator
# end

# def reduce(array, accumulator=0)
#   counter = 0
#   while counter < array.size do
#     curr_element = array[counter]
#     accumulator = yield(accumulator, curr_element)
#     counter += 1
#   end

#   accumulator
# end

# One other thing you may notice is that we use a number (0) as the default initial value for the accumulator, which limits us: we can't use our version with a default value if the data is non-numeric. Compare this to Enumerable#reduce where the default initial value is the first element of the collection.
def reduce(array, accumulator=nil)
  counter = 0

  if accumulator.nil?
    accumulator = array[0]
    counter += 1
  end

  while counter < array.size do
    curr_element = array[counter]
    accumulator = yield(accumulator, curr_element)
    counter += 1
  end

  accumulator
end

array = [1, 2, 3, 4, 5]

p (reduce(['a', 'b', 'c']) { |acc, value| acc += value }) == 'abc'
p (reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value }) == [1, 2, 'a', 'b']
p (reduce(array) { |acc, num| acc + num }) == 15
p (reduce(array, 10) { |acc, num| acc + num }) == 25
reduce(array) { |acc, num| acc + num if num.odd? }        # => NoMethodError: undefined method `+' for nil:NilClass