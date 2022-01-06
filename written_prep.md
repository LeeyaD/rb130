1. What are closures?
A programming concept, it refers to a piece of code that's saved and executed at a later time. Upon their creation closures bind to their surrounding artifacts; retaining references to initialized variables, methods, objects, etc. that were in-scope at the time. There are 3 ways to work with closures and that's (1) instantiating an object from the Proc class, (2) using blocks*, and (3) using lambdas. 
*blocks are not objects and, therefore, can't be saved. Although this contradicts part of our definition for closures, it's okay for the course.

2. What is binding?
A retained reference to the surrounding environment/context, specifically the artifacts (i.e. variables, methods, objects, etc) that are in-scope.

3. How do closures interact with variable scope?
 A closure's binding retains references to surrounding artifacts that were in scope at the time of the closure's creation. Since closures allow us to pass around chunks of code and execute them later, even in other scopes. Bindings allow us to access these retained references even when we're no longer "in-scope".
 ```ruby
 name = "Leeya"
 def a_method(suffix)
  Proc.new { puts suffix + ". #{name}" }
 end

 name1 = a_method("Ms")
 name1.call # NoMethodError raised, `Proc` object created in method definition's self-contained scope. It can't access the local variable `name` unless it's passed in.

 name = "Leeya"
 def a_method(suffix, name)
  Proc.new { puts suffix + ". #{name}" }
 end

 name1 = a_method("Ms", name)
 name1.call 
 #---------------------------------------------------
 name = "Leeya"
 name1 = Proc.new { puts name }
 name1.call # `name` included in binding, initialized at the time of Proc obj's instantiation & in-scope (inner scope has access to the outer scope)

 ```


4. How do blocks work?
Defined with the keywords `do`..`end` or curly braces `{}`, blocks directly following the invocation of a method are passed to the method as an implicit argument. If the keyword `yield` is included in the method's implementation, code execution will jump from the method to the block to run the code there, then execution returns to the method to continue from where it left off. 

Blocks can have parameters and due to a block's lenient arity, no errors are raised if too many or too few arguments are passed to it. When passed more arguments than there are block parameters, the block will ignore the extra arguments. When passed fewer arguments than there are block parameters, the block will set its extra parameters to `nil`).
```ruby
def a_method
  yield('leeya', 'darlene')
end

a_method { |name1| puts "#{name1}"} 
# only the first argument is passed & assigned to the block parameter `name`
a_method { |name1, name2, name3| puts "#{name1}, #{name2}, and #{name3}"} 
# too few arguments are passed so `name3` is set to `nil` which when interpolated is an empty string

```

* What are blocks used for? Give examples of specific use cases
 > 1. When we want to defer some implementation code to method invocation decision. 
 When we (the method implementors) aren't 100% sure what the 'method caller' wants to do. We provide the ability to refine the method implementation without modifying it for others.
 For example, the `#each` method iterates thru a collection, passing each element in the collection to the block to be executed however the method caller. wants since that part of the method's implementation has been left up to them.
 ```ruby
 collection = [1, 2, 3]

 collection.each { |el| puts el } # here the method caller wants to output each collection element

 new_collection = []
 collection.each { |el| new_collection << (el * 2) }
 new_collection
 # here the method caller wants to create a `new_collection` & fill it with the result of performing a mathematical function on the original elements

 new_collection = []
 collection.each { |el| new_collection << el if el > 2 }
 new_collection
 # here the method caller wants to create a `new_collection` & fill it with the elements that meet a certain criteria determined by the method caller
 ```

 > 2. When writing a method that needs to perform some "before" & "after" action 'aka' sandwich code.
For example, wanting to time how long an action takes.
```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
# Here we're calling `Time#now` before & after the action, then outputting the difference (i.e. how long the action took). The action is left up to the method caller.
```


7. When can you pass a block to a method? Why?
Anytime because all Ruby methods can take an optional block as an implicit argument (meaning the method doesn't need to specify the block in its argument list or even execute it at all).

8. How do we make a block argument manditory?
By using the Ruby keyword `yield` in our method implmentation. When the method is invoked without a block argument a `LoadJumpError` will be raised.


9. How do methods access both implicit and explicit blocks passed in?
Implicit blocks can be accessed if a method is defined with the `yield` keyword.
Explicit blocks can be accessed either by calling `Proc#call` on it to execute its code or by name (dropping the unary `&` from the param) to manage like any other object.


10. What is `yield` in Ruby and how does it work?
It's a keyword that we use in method implmenetation that allows us to execute implicitly passed blocks. We can also pass objects to the executed blocks using regular Ruby method-argument syntax.
```ruby
def a_method
  yield
end
a_method { puts "hello" }

def a_method
  yield("leeya")
end
a_method { |name| puts "hello, #{name}" }
```

11. How do we check if a block is passed into a method?
We can call `Kernel#block_given?` which will return `true` if a block has been passed in or `false` otherwise.

12. Why is it important to know that methods and blocks can return closures?
Because a returned closure (Proc or lambda) can be saved to a variable, which can then be managed like any other object. It's the programming concept in action; chunks of code that can be saved and executed later.
*mention bindings being passed around too

13. What are the benefits of explicit blocks?
The increased flexibility. When they become named objects we can pass them around, reassign them, and execute them at a later time--as many times as we want--in other scopes.

14. Describe the arity differences of blocks, procs, methods and lambdas.
Arity refers to the rule regarding the number of arguments that have to be passed.
Blocks & Procs have **lenient arity** which means no errors are raised if too many or too few arguments are passed to them. When passed more arguments than there are parameters, they'll ignore the extra arguments. When passed fewer arguments than there are parameters, they'll set their extra parameters to `nil`).
Methods & Lambdas have **strict** arity, meaning the number of arguments passed must match the number of parameters being defined, otherwise, an ArgumentError will be raised.

15. How do we specify a block argument explicitly?
By prepending the unary & to a parameter in a method definition.

16. What does the unary`&` do when in the method parameter?
Prepended to a method parameter, it creates an optional explicit block parameter that converts a block argument into a "simple" Proc object. This allows us to manage the block (now a Proc object) within the method like any other object to be reassigned, passed to other methods, etc. The `&` is dropped when referring to the parameter inside the method.
```ruby
def a_method(&block)
  block.call
end

a_method { puts "I'm a block turned proc" }
```

17. What does `&` do when in a method invocation argument?
When applied to an argument object for a method, a unary `&` causes ruby to try to convert the object to a block. If the object is a proc, the conversion happens automatically. If the object is not a proc, then Ruby attempts to call `#to_proc` on the object first, then `&` will convert that proc to a block. If there is no `#to_proc` method provided by the object's class a `TypeError` is raised. 


18. How do we utilize the return value of a block?
By assigning it to a variable.
```ruby
def a_method
  a_var = yield
  puts a_var
end

a_method { "Leeya" }
```

19. How can methods that take a block pass pieces of data to that block?
By yielding, with arguments, to the block.
```ruby
def a_method
  yield("Leeya")
end

a_method { |name| puts name }
```

20. What is Symbol#to_proc and how is it used?
```ruby
arr = [1, 2, 3, 4, 5]
p arr.map(&:to_s) # specifically `&:to_s`
# When applied to an argument object for a method, a unary `&` causes ruby to try to convert that object to a block. If that object is a proc, the conversion happens automatically.

p arr.map(&(Proc.new { |n| n.to_s }))
# If the object is not a proc, then `&` attempts to call the `#to_proc` method on the object first. Used with symbols, e.g., &:to_s Ruby creates a proc that calls the #to_s method on a passed object, and....

p arr.map { |n| n.to_s }
# then converts that proc to a block. This is the "symbol to proc" operation (though perhaps it should be called "symbol to block")
```

21. What are Procs and lambdas? How are they different?
Both are Proc objects. Lambda's are a type of Proc that has strict arity while Proc's have lenient.
Lambda's also `return` to their calling method rather than returning immediately like Procs.
```ruby

def proc_demo_method
  proc_demo = Proc.new { return "Only I print!" }
  proc_demo.call
  "But what about me?" # Never reached
end
 
puts proc_demo_method # Only I print!
# (Notice that the proc breaks out of the method when it returns the value.)
 
def lambda_demo_method
  lambda_demo = lambda { return "Will I print?" }
  lambda_demo.call
  "Sorry - it's me that's printed."
end
 
puts lambda_demo_method # Sorry - it's me that's printed.
# (Notice that the lambda returns back to the method in order to complete it.)
```

22. How can we return a Proc from a method or block?
By making sure it’s the last line of code to be evaluated.

### Blocks and variable scope
- **What is variable scope?**
  * The area of a program where a variable is recognized; where it can be accessed and referenced. This area (scope) is determined by where the variable is initialized and so the limits of that variable's scope are defined by a *method definition* or by a *block* that directly follows a method invocation.

**blocks** A method invoked with a block (delimited by either `do`..`end` or `{}`) creates a more open scope. Variables initialized within it cannot be accessed outside of it, but variables initialized outside of it can be accessed from within it.

**method definition** creates a self contained scope. Variables initialized within it cannot be accessed outside of it; variables initialized outside of it can only be accessed within it if they're passed in to the method as arguments when it's invoked. 



# Practice Problems
1. What is happening in the code below?
```ruby
arr = [1, 2, 3, 4, 5]

p arr.map(&:to_s) # specifically `&:to_s`
# When applied to an argument object for a method, a urnary `&` causes ruby to try to convert that object to a block. If that object is a proc, the conversion happens automatically.

p arr.map(&(Proc.new { |n| n.to_s }))
# If the object is not a proc, then `&` attempts to call the `#to_proc` method on the object first. Used with symbols, e.g., &:to_s Ruby creates a proc that calls the #to_s method on a passed object, and....

p arr.map { |n| n.to_s }
# then converts that proc to a block. This is the "symbol to proc" operation (though perhaps it should be called "symbol to block")
```

2. How do we get the desired output without altering the method or the method invocations?
```ruby
def call_this
  yield(2)
end

# your code here
to_s = Proc.new { |n| n }
to_i = Proc.new { |n| n.to_s }

p call_this(&to_s) # => returns 2
p call_this(&to_i) # => returns "2"
```

3. What concept does the following code demonstrate?
```ruby
def time_it
  time_before = Time.now
  yield
  time_after= Time.now
  puts "It took #{time_after - time_before} seconds."
end
# This code demonstrates 'sandwich coding', the method #time_it is performing a "before" & "after" action in this case timing how long an action takes
```

4. What will be outputted from the method invocation block_method('turtle') below? Why does/doesn't it raise an error?
```ruby
def block_method(animal)
  yield(animal)
end

block_method('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
```

4.  What will be outputted if we add the follow code to the code above? Why?
```ruby
block_method('turtle') { puts "This is a #{animal}."}
```

5. What will the method call call_me output? Why?
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

6. What happens when we change the code as such:
```ruby
def call_me(some_code)
  some_code.call
end

chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin"

call_me(chunk_of_code)
```

7. What will the method call call_me output? Why?
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

8. Why does the following raise an error?
```ruby
def a_method(pro)
  pro.call
end

a = 'friend'
a_method(&a)
```

9. Why does the following code raise an error?
```ruby
def some_method(block)
  block_given?
end

bl = { puts "hi" }

p some_method(bl)
```

10. Why does the following code output false?
```ruby
def some_method(block)
  block_given?
end

bloc = proc { puts "hi" }

p some_method(bloc)
```
11. How do we fix the following code so the output is true? Explain
```ruby
def some_method(block)
  block_given? # we want this to return `true`
end

bloc = proc { puts "hi" } # do not alter this code

p some_method(bloc)
```

12. Why do we get an `LocalJumpError` when executing the below code? & How do we fix it so the output is hi? (2 possible ways)
```ruby
def some(block)
  block_given?
  yield
end

bloc = proc { p "hi" } # do not alter
some(bloc)
```
13. What does the following code tell us about lambda's? (probably not assess on this but good to know)
```ruby
bloc = lambda { p "hi" }

bloc.class # => Proc
bloc.lambda? # => true

new_lam = Lambda.new { p "hi, lambda!" } # => NameError: uninitialized constant Lambda
```

14. What does the following code tell us about explicitly returning from proc's and lambda's? (once again probably not assess on this, but good to know ;)
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

```ruby
name = 'Santa'

my_proc = Proc.new do 
  puts name
end
# ---- the code above is for problems #1-3 below -------
# 1.
def my_method(&block)
  block.call
end

my_method(my_proc) { puts "hello" }

# 2.
def my_method(block="optional")
  # block.call
  puts block
end

my_method(my_proc)

# 3.
def my_method(&block)
  block.call
end

my_method(&my_proc)

# 4. 
def my_method(arr, num, string, &block)
  block.call
end

my_method([], 14, 'string') { puts name }

# 5.
def a_method(&a_block)
  a_block.call
end

my_proc = Proc.new { puts "hello" }

a_method(&my_proc) #== a_method { puts "hello" }
```

## Testing With Minitest
G. What is Minitest? How do we get access to it?
A testing framework for Ruby that used to be distributed with it. It's a RubyGem so we can access it using the `gem install` command which will connect to the remote RubyGems Library where the specified gem is downloaded & installed to our local file system.

1. What is a test suite?
The entire set of tests that accompany a program or application; all the tests for a project.

2. What is a test?
A situation or context in which verification checks are made. For example, making sure a task is marked done after executing a method that's expected to perform that function.

3. What is Domain Specific Language (DSL)? 
A specialized language used for a specific purpose, to solve a specific problem. It can be made for programmers or general users.

4. What do testing frameworks provide?
A way to test the quality of our code and an easier time debugging. Using the structure provided by the framework, we’re able to setup a situation for our code and test what we expect our code to do against what actually happens. If the code behaves in a way we weren't expecting, we can use the information from the failed test to help debug our code.

5. What is regression testing?
The process of checking for errors that occur in existing code after changes are made somewhere in the codebase.

6. What is code coverage? How is it used?
Refers to how much of our actual program code (public & private) is tested by a test suite. It's used to inform us, the developer, to where to add more tests so that the code coverage gets closer to 100%.

7. What tools can you use to gauge code coverage for yourself?
We can use the RubyGem, `simplecov`. When executed, a directory-`coverage`-is created and from the `index.html` file we get a report on what percentage of our code is covered as well as which lines of code.

8. What are the differences of Minitest vs RSpec?
RSpec are both testing tools written in the programming language Ruby to test Ruby code. 
RSpec is a DSL that uses code that reads like English
Minitest lets us use normal Ruby syntax but it can also use a DSL.

9. What are the different styles of Minitest?
Minitest has two different styles: 
* Expectation style, which uses a DSL and is more like RSpec, uses describe blocks to group individual tests that begin with the `it` method. These *spec-style* tests use expectation matchers instead of assertions.
* Assert-style, written using regular Ruby code, does not group individual tests. Furthermore, each test starts with `test_` and uses one or more assertions.


9. What is the SEAT approach?
The 4 steps to writing a test:
1. Set up the necessary objects. 
```ruby
def setup    
	@car = Car.new  
end
```
2. Execute the code against the object we’re testing. 
Sometimes just a simple object instantiation.
3. Assert the results of the execution. 
4. Tear down and clean up any lingering artifacts.


10. What are the benefits to the SEAT approach?
The `setup` method allows us to setup the code we’re running our assertions against rather than adding setup code to each & every test method. And in some cases, the `teardown` method is handy when we need to clean up files, log information, or close database connections.

10. When does setup and tear down happen when testing?
The `setup` method is called before running every test.
The `teardown` method is called after running every test.

11. What is an assertion?
The verification step in testing. It verifies that the data returned by our program/application is what is expected. There can be one or more verification steps within a test.

12. Give some examples of common assertions and how they are used. - Added to Anki individually
```ruby
def test_car_exists
  car = Car.new
  assert(car)
end
# `assert(test)` Fails unless test is truthy.
```

```ruby
def test_wheels
  car = Car.new
  assert_equal(4, car.wheels)
end
# `assert_equal(exp, act)`	Fails unless exp == act.
```

```ruby
def test_name_is_nil
  car = Car.new
  assert_nil(car.name)
end
# `assert_nil(obj)`	Fails unless obj is nil.
```

```ruby
def test_raise_initialize_with_arg
  assert_raises(ArgumentError) do
    car = Car.new(name: "Joey")
  end
end
# `assert_raises(*exp) { ... }`	Fails unless block raises one of *exp.
# this code raises ArgumentError, so this assertion passes
```

```ruby
def test_instance_of_car
  car = Car.new
  assert_instance_of(Car, car)
end
```
`assert_instance_of(cls, obj)`	Fails unless obj is an instance of cls.
This test is more useful when dealing with inheritance. 


```ruby
def test_includes_car
  car = Car.new
  arr = [1, 2, 3]
  arr << car

  assert_includes(arr, car)
end

# assert_includes calls assert_equal in its implementation, and Minitest counts that call as a separate assertion. For each assert_includes call, you will get 2 assertions, not 1.
```
`assert_includes(collection, obj)`	Fails unless collection includes obj.


13. What is the difference of assertion vs refutation methods?
They're opposites in their verifications; assertions assert that what occurs is what is expected, meanwhile refutations refute that what occurs is NOT what is expected.

14. How does assert_equal compare its arguments?
Testing for *value equality*, it uses the expected object's `#==` method. If the expected object is from a custom class, the `#==` method must be defined.


---- All notes up to here have been added to Anki deck ---------
----- LEFT OFF HERE---------
### Purpose of core tools
# REVIEW once more, THEN ADD to Anki deck
1. What are the purposes of core tools? / How do the Ruby tools relate to one another?
Collectively core tools help us build our Ruby projects from beginning to end. Each core tool has its own unique function and is used as needed, at different points of our project's development.

# REVIEW once more, THEN ADD to Anki deck
G. What are Ruby Version Managers? Why do we need them? Give some exampled of available Ruby Version Managers and what they can do for you.
They're programs that manage multiple versions of Ruby, the utilities (such as irb) associated with each version, and the RubyGems installed for each Ruby. They allow us to install and uninstall ruby versions and gems, and run specific versions of ruby with specific programs and environments.

# REVIEW once more, THEN ADD to Anki deck
3. What are RubyGems and why are they useful? / What are RubyGems? How are they used? Where can you find them? How do you manage them in your own environment? How do you include them in projects you create?
Also called 'gems', they're packages of code that we can download, install, and use in our Ruby programs or from the command line. There are thousands of gems availabl, so which ones we use depends entirely on our needs. For example, the `pry` gem helps debug Ruby programs while `rubocop` checks for Ruby style guide violations and other potential issues in our code.

# REVIEW once more, THEN ADD to Anki deck
4. What is Bundler? What does it do and why is it useful?
Bundler lets us describe exactly which Ruby and Gems we want to use with our Ruby apps. Specifically, it lets us install multiple versions of each Gem under a specific version of Ruby and then use the proper version in our app.


5. What is Rake? What does it do and why is it useful?
It automates many common functions required to build, test, package, and install programs

a tool that you use to perform repetitive development tasks, such as running tests, building databases, packaging and releasing the software, etc. The tasks that Rake performs are varied, and frequently change from one project to another; you use the Rakefile file to control which tasks your project needs.

Set up required environment by creating directories and files
Set up and initialize databases
Run tests
Package your application and all of its files for distribution
Install the application
Perform common Git tasks
Rebuild certain files and directories (assets) based on changes to other files and directories
In short, you can write Rake tasks to automate anything you may want to do with your application during the development, testing, and release cycles.

very project that aims to produce a finished project that either you or other people intend to use in the future has repetitive tasks the developer needs. For instance, to release a new version of an existing program, you may want to:

Run all tests associated with the program.
Increment the version number.
Create your release notes.
Make a complete backup of your local repo.
Each step is easy enough to do manually, but you want to make sure you execute them in the proper order (for instance, you want to set the new version number before you commit your changes). You also don't want to be at the mercy of arbitrary typos that may do the wrong thing. It's far better to have a way to perform these tasks automatically with just one command, which is where Rake becomes extremely useful.

G. What is the RubyGems format for projects?
G. What is a .gemspec file?

# REVIEW once more, THEN ADD to Anki deck
6. What constitues a Ruby project?
A collection of one or more files used to develop, test, build, and distribute software. The software may be an executable program, a library module, or a combination of programs and library files. The project itself includes the source code (not only Ruby source code, but any language used by the project, such as JavaScript), tests, assets, HTML files, databases, configuration files, and more.


