# In the previous exercise, we wrote a method that emulates Enumerable#each_cons, but limited our method to handling 2 elements at a time. Enumerable#each_cons can actually handle any number of elements at a time: 1, 2, 3, or more.

# Update your each_cons method so it takes an argument that specifies how many elements should be processed at a time.

# Your method may use #each, #each_index, #each_with_object, #inject, loop, for, while, or until to iterate through the Array passed in as an argument, but must not use any other methods that iterate through an Array or any other collection.
=begin
ALGO
- create a method that takes 2 argument, an array & n, and a block
- iterate thru given array, for current element
-- yield to block with 1 argument, the elements in the given array starting w/ the current element for the length of our constant, at_a_time
- return nil
=end

def each_cons(array, n)
  0.upto(array.size-1) do |idx|
    break if array[idx, n].size < n
    p array[idx, n]
    yield(array[idx, n])
  end
  return nil
end

=begin
* splat operator used w/ an array at method invocation is just syntactic sugar
array = [1, 2, 3, 4, 5]
a_method(*array) == a_method(1, 2, 3, 4, 5)

* operator prepended to a parameter at method implementation is so that we can pass in an undefined number of arguments, it turns passed in arguments into an array
def a_method(*args); end
a_method("a", "b", "c") #=> p args would return ["a", "b", "c"]
=end


# hash = {}
# each_cons([1, 3, 6, 10], 1) do |value|
#   hash[value] = true
# end
# p hash == { 1 => true, 3 => true, 6 => true, 10 => true }

# hash = {}
# each_cons([1, 3, 6, 10], 2) do |value1, value2|
#   hash[value1] = value2
# end
# p hash == { 1 => 3, 3 => 6, 6 => 10 }

hash = {}
each_cons([1, 3, 6, 10], 3) do |value1, values|
  p value1
  p values
  hash[value1] = values
end
p hash #== { 1 => [3, 6], 3 => [6, 10] }

# hash = {}
# each_cons([1, 3, 6, 10], 4) do |value1, *values|
#   hash[value1] = values
# end
# p hash == { 1 => [3, 6, 10] }

# hash = {}
# each_cons([1, 3, 6, 10], 5) do |value1, *values|
#   hash[value1] = values
# end
# p hash == {}


# USING * SPLAT AT METHOD INVOCATION & METHOD IMPLEMENTATION
=begin
* splat operator used w/ an array at method invocation is just syntactic sugar
array = [1, 2, 3, 4, 5]
a_method(*array) == a_method(1, 2, 3, 4, 5)
=end
# def a_method(var1, var2, var3)
#   p var1
#   p var2
#   p var3
# end
# array = ["a", "b", "c"]
# a_method(*array)
# a_method(array) #=> raises an ArgumentError; given 1, expected 3
# methods have strict arity


# * operator prepended to a parameter in method implementation is so that we can pass in an undefined number of arguments, it turns passed in arguments into an array
# def a_method(*args)
#   p args
# end
# a_method("a", "b", "c") #=> ["a", "b", "c"]