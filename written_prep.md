## Blocks
### Closures, binding, and scope
1. How does binding affect the scope of closures?**

### How blocks work, and when we want to use them.
2. How do blocks work?**


3. When do we use blocks? (List the two reasons)**

4. Describe the two reasons we use blocks, use examples.**

### Blocks and variable scope
- **What is variable scope?**
  * The area of a program where a variable is recognized; where it can be accessed and referenced. This area (scope) is determined by where the variable is initialized and so the limits of that variable's scope are defined by a *method definition* or by a *block* that directly follows a method invocation.

**blocks** A method invoked with a block (delimited by either `do`..`end` or `{}`) creates a more open scope. Variables initialized within it cannot be accessed outside of it, but variables initialized outside of it can be accessed from within it.

**method definition** creates a self contained scope. Variables initialized within it cannot be accessed outside of it; variables initialized outside of it can only be accessed within it if they're passed in to the method as arguments when it's invoked. 

### Understand that methods and blocks can return chunks of code (closures)
5. Why is it important to know that methods and blocks can return closures?
### Methods with an explicit block parameter
6. How do we make a block argument manditory?
7. What are the benifits of explicit block?
8. How do methods access both implicit and explicit blocks passed in?
### Arguments and return values with blocks
### When can you pass a block to a method
9. When can you pass a block to a method? Why?
### &:symbol
10. What does `&` do when in a the method parameter?
### Arity of blocks and methods
11. Describe the arity differences of blocks, procs, methods and lambdas.

12. What is yield in Ruby and how does it work?**
* - It is a keyword (NOT a method) that allows us to execute implicit blocks that have been passed in.

13. How do we check if a block is passed into a method?

14. What other differences are there between lambdas and procs? (might not be assessed on this, but good to know)


1. What does `&` do when in a method invocation argument?
```ruby
method(&var)
```
2. What is happening in the code below?
```ruby
arr = [1, 2, 3, 4, 5]

p arr.map(&:to_s) # specifically `&:to_s`
```

3. How do we get the desired output without altering the method or the method invocations?
```ruby
def call_this
  yield(2)
end

# your code here

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

20, How do we invoke an explicit block passed into a method using &? Provide example.

21, What concept does the following code demonstrate?
```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
```

22, What will be outputted from the method invocation block_method('turtle') below? Why does/doesn't it raise an error?
```ruby
def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```

23, What will be outputted if we add the follow code to the code above? Why?
```ruby
block_method('turtle') { puts "This is a #{animal}."}
```

24, What will the method call call_me output? Why?
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

25, What happens when we change the code as such:
```ruby
def call_me(some_code)
  some_code.call
end

chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

26, What will the method call call_me output? Why?
```ruby
def call_me(some_code)
  some_code.call
end

def name
  "Joe"
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}

call_me(chunk_of_code)
```

27, Why does the following raise an error?
```ruby
def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)
```

28, Why does the following code raise an error?
```ruby
def some_method(block)
  block_given?
end

bl = { puts "hi" }

p some_method(bl)
```

29, Why does the following code output false?
```ruby
def some_method(block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(bloc)
```

30, How do we fix the following code so the output is true? Explain
```ruby
def some_method(block)
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(bloc)
```

31. Why do we get an `LocalJumpError` when executing the below code? & How do we fix it so the output is hi? (2 possible ways)
```ruby
def some(block)
  block_given?
  yield
end

bloc = proc { p "hi" } # do not alter
```

some(bloc)
* What does the following code tell us about lambda's? (probably not assess on this but good to know)
```ruby
bloc = lambda { p "hi" }

bloc.class # => Proc
bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda
```

* What does the following code tell us about explicitly returning from proc's and lambda's? (once again probably not assess on this, but good to know ;)
```ruby
def lambda_return
  puts "Before lambda call."
  lambda {return}.call
  puts "After lambda call."
end

def proc_return
  puts "Before proc call."
  proc {return}.call
  puts "After proc call."
end

lambda_return #=> "Before lambda call."
              #=> "After lambda call."

proc_return #=> "Before proc call."
```

Problems Andrew wrote during 1:1
```ruby
name = 'Santa'

my_proc = Proc.new do 
  puts name
end

def my_method(&block)
  block.call
end

my_method(my_proc) { puts "hello" } # ArgumentError raised
```

```ruby
def my_method(block="optional")
  # block.call
  puts block
end

my_method(my_proc) # no ArgumentError raised
```

```ruby
def my_method(&block)
  block.call
end

my_method(&my_proc) # no ArgumentError raised
 # review arity & ampersand
```
```ruby
def my_method(arr, num, string, &block) # Defining an explicit BLOCK parameter (lenient arity) has to be at the end; is optional
  block.call
end

my_method([], 14, 'string') { puts name }
```

```ruby
def a_method(&a_block)
  a_block.call
end

my_proc = Proc.new { puts "hello" }

a_method(&my_proc) == a_method { puts "hello" }
```

## Testing With Minitest
1. What is a test suite?
* - the entire set of tests that accompany a program or application; all the tests for a project.
2. What is a test?
* - 
3. What is Domain Specific Language (DSL)? *ask Andrew, seems like it's not to be thought of like Ruby or Python cause Minitest is Ruby but it "can use" a DSL? What does that even mean? "can use a DSL" like we can write it in expectation-style???
4. What do testing framworks provide?
5. What is regression testing?
### Testing terminology
6. What is code coverage?
### Minitest vs. RSpec
7. What are the differences of Minitest vs RSpec?
**RSpec:**
* written to be read like English
* 
**Minitest**
* used to be bundled with Ruby
### SEAT approach
8. What is the SEAT approach and what are its benefits?
9. When does setup and tear down happen when testing?
### Assertions
10. What is an assertion?
* - the verification step in testing. It's when we verify that the data returned by our program/application is what is expected.
* - you make one or more assertions within a test.

11. What is the difference of assertion vs refutation methods?
12. How does assert_equal compare its arguments?




## Core Tools/Packaging Code
### Purpose of core tools
13. What are the purposes of core tools?
14. What is Version Control and why are they useful?
### Gemfiles
15. What are RubyGems and why are they useful?

16. What is Bundler and why is it useful?

17. What is Rake and why is it useful?

18. What constitues a Ruby project?