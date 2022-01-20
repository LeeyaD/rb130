# Write a program that, given a natural number and a set of one or more other numbers, can find the sum of all the multiples of the numbers in the set that are less than the first number. If the set of numbers is not given, use a default set of 3 and 5.

# For instance, if we list all the natural numbers up to, but not including, 20 that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18. The sum of these multiples is 78.

# PROBLEM
# Given a natural number (i.e. a positive number, sometimes zero) and a set containing 1+ numbers. Find the sum of all the multiples of the numbers in the set from 0 or 1 up to BUT NOT including the natural number.
# If no set is given the default should be 3 and 5

# EXAMPLES / TEST CASES
# Need a SumOfMultiples class that contains 3 methods
# 1. Constructor that takes a set of numbers and raises no errors
# 2. #to instant method that takes 1 argument, the natural number
# 3. #to class method that takes 1 argument, the natural number

# Notes/Questions
# ? - is zero being considered a natural number? Start from 1
# If no set is given the default should be 3 and 5

# DS
# Integers as input for both #to methods
# Array of integers as input for constructor method
# Will use array to keep track of multiples to sum

# ALGO
# #new -> takes an array argument, assigning it to an @var
# --> if no argument is given, default to 3 and 5

# @ #to, create method that takes 1 arg, the limit
# - set empty array to 'multiples'
# - COUNTING from 1 up to BUT NOT including limit, for each 'number'
# --> ITERATE thru set and for each 'num'
# -----> IF 'number' can be evenly divided by 'num' add it to 'multiples'
# -----> ELSE do nothing
# - SUM the multiples array
#
# @@ #to leverage using both the constructor & instance method here

class SumOfMultiples
  attr_reader :set

  def initialize(*set)
    @set = set.empty? ? [3, 5] : set
  end

  def to(limit)
    multiples = []
    1.upto(limit - 1) do |number|
      set.each do |num|
        multiples << number if (number % num).zero? && !multiples.include?(number)
      end
    end

    multiples.sum
  end

  def self.to(limit)
    SumOfMultiples.new.to(limit)
  end
end
