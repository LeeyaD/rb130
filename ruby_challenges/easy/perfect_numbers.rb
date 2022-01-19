# The Greek mathematician Nicomachus devised a classification scheme for natural numbers (1, 2, 3, ...), identifying each as belonging uniquely to the categories of abundant, perfect, or deficient based on a comparison between the number and the sum of its positive divisors (the numbers that can be evenly divided into the target number with no remainder, excluding the number itself). For instance, the positive divisors of 15 are 1, 3, and 5. This sum is known as the Aliquot sum.

# Perfect numbers have an Aliquot sum that is equal to the original number.
# Abundant numbers have an Aliquot sum that is greater than the original number.
# Deficient numbers have an Aliquot sum that is less than the original number.
# Examples:

# 6 is a perfect number since its divisors are 1, 2, and 3, and 1 + 2 + 3 = 6.
# 28 is a perfect number since its divisors are 1, 2, 4, 7, and 14 and 1 + 2 + 4 + 7 + 14 = 28.
# 15 is a deficient number since its divisors are 1, 3, and 5 and 1 + 3 + 5 = 9 which is less than 15.
# 24 is an abundant number since its divisors are 1, 2, 3, 4, 6, 8, and 12 and 1 + 2 + 3 + 4 + 6 + 8 + 12 = 36 which is greater than 24.
# Prime numbers 7, 13, etc. are always deficient since their only divisor is 1.
# Write a program that can tell whether a number is perfect, abundant, or deficient.

# PROBLEM
# Write a program that determines whether a given number is perect, abundant, or deficient.

# Notes:
# categories are based on a comparison between the given number & the sum ('aka' aliquot) of it's positive divisors
# -- perfect: aliquot equals given number
# -- abundant: aliquot is greater than given number
# -- deficient: aliquot is less than given number
# divisors: numbers that can evenly divide the given number w/ no remainders
# aliquot does not include the given number itself
# Prime numbers are always deficient since their only divisor is 1

# EXAMPLES / TEST CASES
# Need a PerfectNumber class with 2 methods (X) only need 1 method
# 1. Constructor method that raises an error when given a negative number (X)
# 2. a class method, #classify that:
# ----> takes 1 argument, the given number
# ----> returns a string, the class of number; 'perfect', 'deficient', or 'abundant'
# ----> raises an error when passed a negative number

# DS
# input: an integer
# output: a string
# use an array to capture factors & sum them

# ALGO
# - Create a class, PerfectNumber
# - Create a class method #classify that takes 1 argument, a number
# - Raise a StandardError if number is negative
# - FIND & SAVE given numbers divisors from 1 up to but not including the number itself
# - SUM divisors
# - RETURN 'perfect' if sum = given number
# - RETURN 'deficient' if sum < given number
# - RETURN 'abundant' if sum > given number

class PerfectNumber
  def self.classify(number)
    raise StandardError.new if number.negative?

    aliquot = find_aliquot(number)

    if aliquot == number
      'perfect'
    elsif aliquot > number
      'abundant'
    else
      'deficient'
    end
  end

  class << self # adding a private instance method to class obj, thereby, creating a private class method
    private

    def find_aliquot(number)
      (1...number).select { |num| (number % num).zero? }.sum
    end
  end
end
