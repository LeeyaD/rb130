# For this exercise, we'll be learning and practicing our knowledge of the arity of lambdas, procs, and implicit blocks. Two groups of code also deal with the definition of a Proc and a Lambda, and the differences between the two. Run each group of code below: For your answer to this exercise, write down your observations for each group of code. After writing out those observations, write one final analysis that explains the differences between procs, blocks, and lambdas.

# Group 1
puts "Group 1"
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc #=> Object class, encoding, and even the file it was created in & line number created on
puts my_proc.class # Proc class
my_proc.call # => This is a . 
my_proc.call('cat') # => This is a cat.
# Arity: A proc has lenient arity, meaning an ArgumentError won't be raised if too few or too many arguments than block parameters are passed. Here, too few arguments were passed and the extra param was set to `nil`. We know this because where `thing` was interpolated, there's a space and nil interpolated is an empty space. 
# Tracking: Procs keep track of when & where they were created (line number & file).

# Group 2
puts "Group 2"
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda #=> Object class, encoding, and even the file it was created in & line number created on
puts my_second_lambda #=> Object class, encoding, and even the file it was created in & line number created on
puts my_lambda.class # Proc class
my_lambda.call('dog') # This is a dog.
# my_lambda.call # ArgumentError raised, expected 1, given 0
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." } #NameError raised, uninitialized constant Lambda
# Arity: A lambda has strict arity, meaning an ArgumentError will be raised if too few or too many arguments than block parameters are passed.
# A lambda a type of Proc object and can therefore not be created with the #new method (NameError raised since `Lambda` isn't a valid class Ruby thinks it's an uninitialized constant). I can be created one of two ways; 1) `lambda {}` or 2) `-> (param) {}`. Lambdas also keep track of when & where they were created (line number & file).

# Group 3
puts "Group 3"
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."} # This is a .
# block_method_1('seal') # LocalJumpError
# Arity: A block has lenient arity, meaning an ArgumentError won't be raised if too few or too many arguments than block parameters are passed. Here, too few arguments were passed and the extra param was set to `nil`. We know this because where `seal` was interpolated, there's a space and nil interpolated is an empty space.
# When the keyword 'yield' is present and not wrapped in a 'block_given?' if conditional, a block must be passed at method invocation or a LocalJumpError is raised.

# Group 4
puts "Group 4"
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."} # This is a turtle.
block_method_2('turtle') do |turtle, seal|  # This is a turtle and a .
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."} # NameError, undefined local variable or method

# Arity: A block has lenient arity, meaning an ArgumentError won't be raised if too few or too many arguments than block parameters are passed. Here, too few arguments were passed and the extra param was set to `nil`. We know this because where `seal` was interpolated, there's a space and nil interpolated is an empty space.
