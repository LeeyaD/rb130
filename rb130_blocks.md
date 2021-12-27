## Blocks
### Closures in Ruby
* "Chunks of code" *saved* and executed at a later time.
* 3 ways to work w/ closures:
  1. Instantiating an object from the `Proc` class
  2. Using blocks
  3. Using lambdas
* They're **binding** in that they retain references to their surrounding *artifacts* (i.e. variables, methods, objects, etc)


### Writing Methods w/ Blocks
* In Ruby, every method can take an optional block as an **implicit** argument meaning it doesn't need to specify the block in its argument list or even execute the block at all.

#### Yielding
It lets us invoke our passed in block argument from within the method
* wrap in a conditional using `Kernel#block_given?` to allow method w/ `yield` to be invoked with or without a block (i.e. without raising a `LoadJumpError`)
* **Use case #1:** `Yield` allows future developers to inject additional code in our method without modifying the method implementation.

#### Yielding w/ an argument
```ruby
3.times do |num|
  puts num
end
```
`3` is the calling object.
`times` is the method being invoked
`num` between the pipes, `| |`, is the *block paramenter*
`num` **within the block** is the *block local variable*

* **Remember** not to name your *block parameter* the same name as a local variable defined outside the block as this will cause *variable shadowing* (i.e. we won't be able to access the variable in the outer scope).

**To add to the previous use case**, we can make our methods flexible by passing an argument to the block. This allows users to do what they will with that argument at method invocation time.

**arity** rule regarding the number of arguments you have to pass to a block, `proc`, or `lambda`.
  * blocks & `proc`s have **lenient arity** which means Ruby won't raise an error if we pass too few or too many arugments to either
  * methods & `lambda`s have **strict arity** meaning we have to pass the exact number of arguments that the method or `lambda` expects or Ruby will raise an `ArgumentError`.

**Arity** rules are ignored when dealing with complex method arguments (e.g. optional, variable, variable keyword, etc.). Optional parameters in a method or block? Arity rules don't apply to those arguments.


#### Return value of yielding to a block
```ruby
def compare(str)
  puts "Before: #{str}"
  after = yield(str)
  puts "After: #{after}"
end

compare('hello') { |word| word.upcase }
```
Blocks, like methods, have a return value and it's the last expression evaluated in the block too.

REMEMBER: `nil` in string interlpolation evaluates to an empty string.

#### When to use blocks in your own methods
Two main use cases:
1. Defer some implementation code to method invocation decision.
* **What?** *Method implementor* isn't 100% sure what the *method caller* wants to do so the ability to *refine* the method implementation without modifying it for others is provided.
* **Why?** Life without blocks, is a long list of `flags` for the use (method caller) to use to specify what they want. Or it's a lot more methods, each with a slightly different implementation (`#transform_all`, `#transform_every_other`, etc.).
```ruby
def compare(str, flag)
  after = case flag
          when :upcase
            str.upcase
          when :capitalize
            str.capitalize
          # etc, we could have a lot of 'when' clauses
          end

  puts "Before: #{str}"
  puts "After: #{after}"
end

compare("hello", :upcase)
```
* **When?** If you're calling a method from multiple places, with one little tweak in each case, it may be a good idea to try implementing the method in a generic way by yielding to a block.

2. Methods that need to perform some "before" and "after" actions - **sandwich code**.
* **What?** Generic code that performs a 'before' & 'after' action that's left to the *method caller* to determine.
* **Why?** Timing, logging, notification systems are all examples where before/after actions are important. Another area is in resource manangemment, or interfacing with the operating system. Many OS interfaces require developers to first allocate a portion of a resource, then perform some 'clean-up' to free up that resource. Forgetting to do the clean-up can result in dramatic bugs -- system crashes, memory leaks, file system corruption. Sandwich code allows us to automate this clean-up.


#### Methods with an explicit block parameter
An **explicit block** is a block that gets assigned to a method parameter so that it can be managed like any other object -- it can be reassigned, passed to other methods, and invoked many times.

To define an explicit block, add a parameter to the method definition that begins with an `&` (ampersand) character.
If method takes multiple arguments, the explicit block parameter must be last.
```ruby
def test(&block)
  puts "What's &block? #{block}"
end

test { sleep(1) }

# What's &block? #<Proc:0x007f98e32b83c8@(irb):59>
# => nil
```
* The `&` is a special parameter that converts the block into a simple `Proc` object.
* `&` is dropped when referring to the parameter inside the method.

**Why an explicit block parameter?** 
Provides more flexibility, without a variable to assign the block to we can't do anything beyond `yielding` to it and testing to see if it's there. 

With a variable that represents the block, we can managed it like any other object -- it can be reassigned, passed to other methods, and invoked many times.
```ruby
def display(block)
  block.call(">>>") # Passing the prefix argument to the block
end

def test(&block)
  puts "1"
  display(block)
  puts "2"
end

test { |prefix| puts prefix + "xyz" }
```
Here we're calling the `#test` method and passing it the following block `{ |prefix| puts prefix + "xyz" }`. The block is passed in and assigned an explicit block parameter `&block`. This parameter, made special by `&`, converts the passed in block into a simple `Proc` object and assigns it to the parameter name prepended by `&`, in this case `block`. We pass the method local variable `block` which references the `Proc` object to the `display` method as an argument. In the `#display` method the passed in block is assigned to the `block` parameter and on the next line we're calling the block with `Proc#call` and passing to it one argument; the string object `">>>"`. The string object gets passed to the `Proc` block and assigned to the block local parameter `prefix`. The block calls `#puts` on `prefefix + "xyz"` which outputs `>>>xyz` and returns `nil`.

**Important note:** Things get a bit more complicated if the caller passes in a `Proc` object, a `lambda`, or some other object to a method that takes an explicit block. But we won't go into that.

#### Using Closures
Closures retain the memory of their surrounding scope and can use and even update variables in that scope when they're executed, even if the block, `Proc`, or `lambda` is called from somewhere else.
```ruby
def for_each_in(arr)
  arr.each { |element| yield element }
end

arr = [1, 2, 3, 4, 5]
results = [0]

for_each_in(arr) do |number|
  total = results[-1] + number
  results.push(total)
end

p results # => [0, 1, 3, 6, 10, 15]
```
* Although the block called with `#for_each_in` is called from inside the method (thanks to `yield`), it still has access to the `results` array thru closure.

Closures are especially powerful when a method or block returns them. Although we implement closures in blocks, `Proc`s and `lambdas` we can only return `Proc`s and `lambda`s (the diff. is mainly in syntax).
```ruby
def sequence
  counter = 0
  Proc.new { counter += 1 }
end

s1 = sequence
p s1.call           # => 1
p s1.call           # => 2
p s1.call           # => 3
puts

s2 = sequence
p s2.call           # => 1
p s1.call           # => 4 (note: this is s1)
p s2.call           # => 2
```
* `#sequence` method returns a newly created `Proc` object that forms a closure with the local variable `counter`
* Each time we called `Proc`, it incremented its own private copy of the `counter` variable.
* We can create multiple `Proc`s from `#sequence`, and each will have its own independent copy of `counter`. We see this when we call `#sequence` for a second time, assigning the return value (the `Proc` object) to `s2`. When we call our `Proc` object on `s2` the counter starts at 1. This demonstrates that the bound artifacts are separate and indepent of each other.

#### Summary
* blocks are a good use case for "sandwich code" scenarios, like closing a `File` automatically.
* methods and blocks can return a chunk of code by returning a `Proc` or `lambda`.


### Assignment: TodoList
Working w/ `Todo` objects and creating a *collection* class `TodoList`
**Why?** Using our own collection class allows us to add our own collection level attributes as well as behaviors specifc to a *todo lists*. For example:
* we can add a title or due date for our collection of `Todo`s
* we can make sure our collection class only deals with `Todo` objects

Backing mechanism being used internally in our `TodoList` class is an `Array`. 

**LS solution vs. My solution**
* I could have utilized my own methods more (e.g. using `#item_at` which relies on `#fetch` rather than `#fetch`!)
* LS coded this `@todos.delete(item_at(idx))` compared to what I wrote, `todos.delete_at(idx) if self.item_at(idx)`
* LS's `#to_s` method made use of `\n` the new line character after making one long string of a title & items.


### Assignment: TodoList#each
I was missing how to piggy-back off of `Array#each`
```ruby
  def each
    @todos.each do |todo|
      yield(todo)
    end
  end
```
The answer was to do it from **within** it!

### Assignment: TodoList methods
Don't need `self` because `#each` and `#select` know what collection they're iterating through! I defined them with `self`!
```ruby
  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end
```
If title isn't found, `nil` is returned which `#done!` can't handle (NoMethodError is railed because we're trying to call it for `nil:NilClass`). So using `&&` helps because it'll short circuit if no title is found and not even attempt to mark a non-existent todo object done.


### Blocks and Variable Scope

#### Local variable scope refresher
* A local variable's scope is determined by where it's initialized.
* Method invocation followed by a block (defined by `do...end` and curly braces {}), creates a new scope.
* Outer local variables are accessible in the inner scope but not vice versa.
* Method definitions create a self-contained scope and, therefore, can only access variables iniitalized inside the method or ones defined as parameters (use to assign to objects that are passed in).

#### Closure and binding
In order for our **closure** (the saved 'chunk of code') to be passed around and executed at a later time, it must understand the surrounding context from where it was defined.
```ruby
def call_me(some_code)
  some_code.call
end

name = "Robert"
chunk_of_code = Proc.new {puts "hi #{name}"}
name = "Griffin III"  # re-assign name after Proc initialization

call_me(chunk_of_code)
```
`hi Griffin III` is outputted and `nil` is returned.
The `Proc` object kept track of its **binding** (surrounding environment/context), so that it had all the information it needed to be executed later on.
**Bindings** include; local variables, method references, constants and other artifacts -- whatever it needs to execute correctly.

**Important note:**any local variables being accessed by a closure must be defined before the closure is created. Only exception is if the local variable is explicitly passed to the closure when it is called (e.g., `some_proc.call(some_variable)`). If we remove `name = "Robert"` in the code above, it'd change the binding of the `Proc` object & `name` would no longer be *in scope* since it is initialized after the `Proc` is instantiated.

Srdjan: If we try to invoke a method without an explicit caller and without parentheses, Ruby will *first* check to see if there is a local variable of that name within scope (which in the case of a block includes it's binding), if there is then Ruby will return the object referenced by the local variable, if not it will attempt to call a method of that name on self. 

Ginni: In order for local variables to be a part of a closures binding, they must be initialized before the closure is created unless they are explicitly passed into the closure.

##### Me trying to understand why exactly
**WITH `name = 'Robert'`**
`name` in `{puts "hi #{name}"}` is a local variable that's been initialized before the `Proc` object was created which means `name` will be in the `Proc` object's bindings. When we invoke the `#call` method on the `Proc` object, Ruby finds the local variable in the `Proc`s bindings and returns the value it references, which may or may not have been reassigned between the time the `Proc` object was created and the time the `Proc` object is invoked.

**WITHOUT `name = 'Robert'`**
`name` in `{puts "hi #{name}"}` is an uninitialized local variable at the time the `Proc` object was created which means it won't be part of its bindings. When we invoke the `#call` method on the `Proc` object, Ruby first checks to see if there's a local variable by that name *within scope*...meaning initialized at the time the `Proc` was created and therefore part of its bindings. Ruby won't find a local variable with that name in the `Proc`s bindings, so Ruby will attempt to call it like a method. Since there is no explicit caller, Ruby will invoke the method *implicitly* on `self` but because there are no methods defined in scope with that name--irregardless of when the `Proc` object was create--an `undefined local variable or method NameError` is raised.


### Symbol to proc
```ruby
[1, 2, 3, 4, 5].map { |num| num.to_s } # From this...
[1, 2, 3, 4, 5].map(&:to_s) # To this...
```
`&:to_s` is a shortcut we can use when working with collections. It allows us to call the method, by it's symbol name, on every element of our collection.
* It cannot be used on methods that take arguments
* It can be used on any collection method that take a block

#### Symbol#to_proc
It's very common to want to transform all items in a collection by calling the same method on each element so a shortcut was created. When calling methods with blocks we can use the symbol-to-proc trick that take this: `&:to_s` and converts it to this: `{ |n| n.to_s }`. 

The `&` character is prepended to an object (possibly referenced by a variable) to convert the object into a block. If the object is already a `Proc` Ruby can convert it to a block naturally but if the object isn't a '`Proc`, which is the case here `&:to_s` (or object is a `Symbol`), we'll have to first convert it to one. And so, Ruby will call `#to_proc` to return a `Proc` object, then convert the resulting Proc to a block.

**Within a method invocation**, using `&` in front of the last argument converts the argument to a Proc, if necessary, then converts the Proc to a block
```ruby
[1, 2, 3].map(&:odd?)    # & within a method invocation
# &:odd? becomes { |n| n.odd? }
```

**Within a method definition**, the `&` is a special parameter that converts the optional block being passed in as an argument, into a simple `Proc` object. Furthermore, the `Proc` object is assigned to the parameter name that follows the ampersand character. This gives us the ability to refer to an optional block being passed in, within the method body.
```ruby
def some_method(&block)   # & within a method definition
  block.call
end

some_method { puts "hi from the explicit block!" }
```

num = 1

x = Proc.new { num += 1 }

p x.call
p x.call
p x.call

x2 = Proc.new { num += 1 }

p x2.call