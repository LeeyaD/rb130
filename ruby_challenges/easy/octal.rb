# PROBLEM
# Convert a given octal input string convert it to a decimal. 
# Invalid input should be treated as octal 0
# CANNOT use any build-in methods for the conversion

# EXAMPLES / TEST CASES
# Need an Octal class that has 2 methods
# 1. Constructor
# --> doesn't raise an error
# --> takes 1 arg, string input
# 2. #to_decimal instance method
# --> takes no arguments
# --> returns an integer

# DS
# input is a string
# output is an integer
# will need an array to break up & convert digits from octal to decimal

# ALGO
# Create #to_decimal method
# - return 0 is anything other than the digits 0-7 are included in octal
# - CONVERT string to an array
# - MUTATE array of strings into an array of integers
# - SAVE size of array to a var, 'n'
# - ITERATE thru array, transform each integer
# --- reduce n by 1
# --- multiply curr_int by the result of 8 multiplied by itself, n number of times
# - RETURN sum of array


class Octal
  attr_reader :octal

  def initialize(octal)
    @octal = octal
  end

  def to_decimal
    return 0 if octal.match?(/[^0-7]/)

    int_arr = octal.chars.map(&:to_i)
    n = int_arr.size

    int_arr.map do |int|
      n -= 1
      int * (Array.new(n, 8).reduce(1, :*))
    end.sum
  end
end
