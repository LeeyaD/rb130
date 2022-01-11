### Why write tests?**
For beginner, the reason is simply to prevent regression. When we make changes in our code, we don't want to have to manually verify everything still works.

Most likely, you'll need to do a mix of writing tests first and writing tests after implementation; jumping back and forth between implementation and testing code.

### Lecture: Minitest
Functionally Minitest and RSpec are the same.
RSpec is what we call a Domain Specific Language; it's a DSL for writing tests. 
Minitest can use a DSL (expectation syntax) and it can also use assertion-style syntax that's more like ordinary Ruby.

#### Vocabulary
**Test Suite:** The entire set of tests that accompanies your program or application; all the tests for a project.
**Test:** The situation or context in which tests are run. A test can contain multiple assertions.
**Assertion:** The verification step to confirm that the data returned by our program/application is what is expected. You make one or more assertions within a test.

#### Colorize
Add the following towards the top after `require 'minitest/autorun'`
```ruby
require "minitest/reporters"
Minitest::Reporters.use!
```

#### Test File
```ruby
require 'minitest/autorun'      # loads all necessary files from minitest gem

require_relative 'car'          # looks for file in current file's directory

class CarTest < Minitest::Test  # having out test class inherit all the necessary methods for writing tests
  def test_wheels               # tests are instance methods, `test_` tells minitest they're individual tests to run
    car = Car.new               # setting up the data/objects to make assertions against
    assert_equal(4, car.wheels) # an instance method that starts w/ `assert_`, it's what we're trying to verify
  end
end
```
`assert_equal(4, car.wheels)` assert_equal(expected value, actual value)
* If there's a discrepancy, the assertion saves the error message which `Minitest` will report on at the end of the test run.

#### Skipping Tests
```ruby
#....omitted for brevity
  def test_bad_wheels
    skip                  # Ruby keyword to skip a particular test
    car = Car.new
    assert_equal(3, car.wheels)
  end
  ```

#### Expectation Syntax
Minitest code above written in *assertion-style* syntax but there's also *expectation*/*spec-style* syntax that's like RSpec.
```ruby
require 'minitest/autorun'

require_relative 'car'

describe 'Car#wheels' do        # tests grouped into `describe` blocks
  it 'has 4 wheels' do          # individual tests begin with the `it` method
    car = Car.new
    _(car.wheels).must_equal 4  # this is the expectation matcher rather than an assertion
  end
end
```
Output of running the tests looks the same whether they were written assertion-style or expectation-style.

### Assertions
Some common assertions...
```ruby
def test_car_exists
  car = Car.new
  assert(car)       # `assert(test)` Fails unless test is truthy.
end
```

```ruby
def test_wheels
  car = Car.new
  assert_equal(4, car.wheels)   # `assert_equal(exp, act)`	Fails unless exp == act.
end
```

```ruby
def test_name_is_nil
  car = Car.new
  assert_nil(car.name)    # `assert_nil(obj)`	Fails unless obj is nil.
end
```

```ruby
def test_raise_initialize_with_arg
  assert_raises(ArgumentError) do
    car = Car.new(name: "Joey")       # this code raises ArgumentError, so this assertion passes
  end
end
```
`assert_raises(*exp) { ... }`	Fails unless block raises one of *exp.

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


#### Refutations
* A minitest writing style that's the opposite of assertions, they refute rather than assert. 
* Every assertion has a corresponding refutation. e.g., assert's opposite is refute. refute passes if the object you pass to it is falsey. 
* Refutations all take the same arguments, except it's doing a refutation. 
* There is a refute_equal, refute_nil, refute_includes, etc.


### SEAT Approach
4 steps to writing a minitest
1. Set up the necessary objects.
2. Execute the code against the object we're testing.
3. Assert the results of the execution.
4. Tear down and clean up any lingering artifacts.

```ruby
  def setup
    @car = Car.new
  end
```
The `setup` method is called before running every test, it allows us to setup the code we’re running our assertions against rather than adding setup code to each & every test method.

There is a `teardown` method (which we don't have) that's called after running every test. In some cases, we will need a tear down for cleaning up files or logging some information, or closing database connections.

Simplest cases don't need either setup or tear down. At the minimum, we'll need EA, even if `E` is a simple object instantiation.

When using `setup` we assign the instantiated an object to an instance variable this way our tests--which are instance methods--have access to it

### Testing Equality
`assert_equal` tests for *value* equality. We're invoking the `==` method on the object. 
```ruby
require 'minitest/autorun'

class EqualityTest < Minitest::Test
  def test_value_equality
    str1 = "hi there"
    str2 = "hi there"

    assert_equal(str1, str2)   # passes since `String#==` returns true
    assert_same(str1, str2)    # fails w/ error message that includes their object ids
  end
end
```
The `assert_same` assertion is for object equality; objects being compared must be the same object.

#### Equality w/ a custom class
In the code from the previous example `assert_equal(str1, str2)` passed, when comparing two strings the `String#==` was used to determine their equality.

If we want to use `assert_equal` with a custom class, we need to show minitest how to assert value equality by writing our own `==` method.
```ruby
class Car
  attr_accessor :wheels, :name

  def initialize
    @wheels = 4
  end

  def ==(other)
    car.is_a?(Car) && name == other.name
  end
end

class CarTest < MiniTest::Test
  def test_value_equality
    car1 = Car.new
    car2 = Car.new

    car1.name = "Kim"
    car2.name = "Kim"

    assert_equal(car1, car2)
  end
end
```

### Code coverage
How much of our actual program code is tested by a test suite.
* Code coverage is based on all of your code, both public and private.
* This doesn't mean edge cases are considered, or that our program is working correctly. Only that we have some tests in place for every method.
* Code coverage is one metric that you can use to gauge code quality.
* It's not always necessary to get 100% coverage, but the % should depend on the type of project you work on. The more fault tolerant it has to be, the higher the test coverage.