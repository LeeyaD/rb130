# Mirror behavior of Array#select
# def select(array)
#   counter = 0
#   new_array = []
#   while counter < array.size do
#     result = yield(array[counter])

#     if result
#       new_array << array[counter]
#     end

#     counter += 1
#   end

#   new_array
# end


#  LS solution!
# def select(array)
#   counter = 0
#   result = []

#   while counter < array.size
#     current_element = array[counter]
#     result << current_element if yield(current_element)
#     counter += 1
#   end

#   result
# end
# Noted that we could have used Array#each to iterate

def select(array)
  results = []

  array.each do |element|
    results << element if yield(element)
  end

  results
end

array = [1, 2, 3, 4, 5]

p (select(array) { |num| num.odd? }) == [1, 3, 5]
p (select(array) { |num| puts num }) == [] # => [], because "puts num" returns nil and evaluates to false
p (select(array) { |num| num + 1 }) == [1, 2, 3, 4, 5]       # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true