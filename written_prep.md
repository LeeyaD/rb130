## Blocks
### Closures, binding, and scope
**How does binding affect the scope of closures?**
Bindings contain artifacts that are 'in-scope' at the time of a closure's creation. Since closures allow us to pass around chunks of code and execute them elsewhere, even in other scopes (e.g. from inside a method). Bindings allow us to access these retained references even when we're no longer "in-scope".

### How blocks work, and when we want to use them.
**What are blocks?**
Blocks are defined by either the Ruby keywords `do`..`end` or curly braces `{}`. When used directly following a method invocation, it gets passed to the method inmplicitly. Depending on the method's implementation (i.e. whether there is an explicit block parameter or the keyword `yield`), the block may or may not be executed. Blocks can have parameters and due to a block's lenient arity, it can be passed too many or too few arguments without raising an error (too many and the block will ignore extra args; too few and the block will set extra params to `nil`).

syntax >> arity >> scope >> variable shadowing >> 


**When do we use blocks? (List the two reasons)**
1. When we want to defer some implementation code to method invocation decision. 
2. When writing a method that needs to perform some "before" & "after" action 'aka' sandwich code.

**Describe the two reasons we use blocks, use examples.**
1. When we want to defer some if our implementation code to method invocation decision because we (the method implementors) aren't 100% sure what the 'method caller' wants to do. We provide the ability to refine the method implementation without modifying it for others.
For example, the `#each` method iterates thru a collection, passing each element in the collection to the block to be executed however the method caller wants

2. When writing a method that needs to perform some "before" & "after" action 'aka' sandwich code. The action in question is left to the 'method caller' to determine.
For example, if we wanted to time how long an action takes we could call `Time#now` before & after the action, then return the difference.

### Blocks and variable scope
- **What is variable scope?**
  * The area of a program where a variable is recognized; where it can be accessed and referenced. This area (scope) is determined by where the variable is initialized and so the limits of that variable's scope are defined by a *method definition* or by a *block* that directly follows a method invocation.

**blocks** A method invoked with a block (delimited by either `do`..`end` or `{}`) creates a more open scope. Variables initialized within it cannot be accessed outside of it, but variables initialized outside of it can be accessed from within it.

**method definition** creates a self contained scope. Variables initialized within it cannot be accessed outside of it; variables initialized outside of it can only be accessed within it if they're passed in to the method as arguments when it's invoked. 

### Understand that methods and blocks can return chunks of code (closures)
5. Why is it important to know that methods and blocks can return closures?
### Methods with an explicit block parameter
**How do we make a block argument manditory?**
By using the Ruby keyword `yield`

7. What are the benifits of explicit block?
8. How do methods access both implicit and explicit blocks passed in?
### Arguments and return values with blocks
### When can you pass a block to a method
**When can you pass a block to a method? Why?**
Always because all Ruby methods can take blocks passed implicitly.

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
irb

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
##### What is a test suite?
The entire set of tests that accompany a program or application; all the tests for a project.

##### What is a test?
* - 

##### What is Domain Specific Language (DSL)? 
*ask Andrew, seems like it's not to be thought of like Ruby or Python cause Minitest is Ruby but it "can use" a DSL? What does that even mean? "can use a DSL" like we can write it in expectation-style???

#### What do testing framworks provide?

#### What is regression testing?

### Testing terminology
##### What is code coverage?
How much of our actual program code (all of it, public & private) is tested by a test suite. We can test for this with the RubyGem, `simplecov`.

##### What are the differences of Minitest vs RSpec?
**RSpec:**
* a DSL testing tool written in the programming language Ruby to test Ruby code
* a unit test framework for the Ruby programming language
* written to be read like English
* can also use a DSL?? but it can also be used in a way that reads like ordinary Ruby code without a lot of magical syntax. 
**Minitest**
* used to be bundled with Ruby

#### What is the SEAT approach and what are its benefits?
#### When does setup and tear down happen when testing?


#### What is an assertion?
* - the verification step in testing. It's when we verify that the data returned by our program/application is what is expected.
* - you make one or more assertions within a test.

#### What is the difference of assertion vs refutation methods?
Their writing styles are opposite; assertions pass when they

#### How does assert_equal compare its arguments?
Using the expected object's `#==` method (e.g.; `Array#==`, `String#==`, etc.). If the expected object is from a custom class, the `#==` method must be defined.



### Purpose of core tools
##### What are the purposes of core tools?
Collectively core tools help us build our Ruby projects from beginning to end. Each core tool has its own unique function and is used as needed, at different points of our project's development.

##### What are Version Control Managers and why are they useful?
They're programs that manage multiple versions of Ruby, the utilities (such as irb) associated with each version, and the RubyGems installed for each Ruby. They allow us to install and uninstall ruby versions and gems, and run specific versions of ruby with specific programs and environments.

##### What are RubyGems and why are they useful?
Also called 'gems', they're packages of code that we can download, install, and use in our Ruby programs or from the command line. There are thousands of gems availabl, so which ones we use depends entirely on our needs. For example, the `pry` gem helps debug Ruby programs while `rubocop` checks for Ruby style guide violations and other potential issues in our code.

##### What is Bundler and why is it useful?
Bundler lets us describe exactly which Ruby and Gems we want to use with our Ruby apps. Specifically, it lets us install multiple versions of each Gem under a specific version of Ruby and then use the proper version in our app.

##### What is Rake and why is it useful?
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

##### What constitues a Ruby project?
A collection of one or more files used to develop, test, build, and distribute software. The software may be an executable program, a library module, or a combination of programs and library files. The project itself includes the source code (not only Ruby source code, but any language used by the project, such as JavaScript), tests, assets, HTML files, databases, configuration files, and more.

### notes from call w/ James/Oscar
**how is it used?** Prepend a method parameter with the unary &; within the method itself refer to block parameter (which is now a "simple" Proc object) without the & (i.e. to pass it to another method, when invoking with Proc#call, etc.)

# what is it? The &block is a special parameter that converts the block argument to what we call a "simple" Proc object 

# why do we use explicit blocks? because it allows additional flexibility 

The whole point of a Proc is to be able to save a block

## Blocks
What are Procs and lambdas? How are they different?
How do closures interact with variable scope?
What are blocks used for? Give examples of specific use cases
How do we write methods that take a block? What erros and pitfalls can arise from this and how do we avoid them?
How do we utilize the return value of a block? How can methods that take a block pass pieces of data to that block?
What is Symbol#to_proc and how is it used?
How do we specific a block argument explicitly?
How can we return a Proc from a method or block?
What is arity? What kinds of things in Ruby exhibit arity? Give explicit examples.

## Testing
What is Minitest? How do we get access to it?
What are the different styles of Minitest?
What is RSpec? How does it differ from Minitest?
What is a test suite? What is a test?
What are assertions? How do they work?
Give some examples of common assertions and how they are used.
What is the SEAT approach?
What is code coverage and how is it used? What tools can you use to gauge code coverage for yourself?

## Core Ruby Tools
What are RubyGems? How are they used? Where can you find them? How do you manage them in your own environment? How do you include them in projects you create?
What is the RubyGems format for projects?
What are Ruby Version Managers? Why do we need them? Give some exampled of available Ruby Version Managers and what they can do for you.
What is Bundler? What does it do and why is it useful?
What is Rake? What does it do and why is it useful?
What is a .gemspec file?
How do the Ruby tools relate to one another?