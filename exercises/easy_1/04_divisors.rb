# Write a method that returns a list of all of the divisors of the positive integer passed in as an argument. The return value can be in any sequence you wish.

# Input: positive integer
# ? - how to handle bad input?
# Output: all divisors of given input

# DS: an array
# ALGO:
# 1. Create a method that takes a positive integer
# --- Init. 'results' to an empty array
# 2. COUNT from 0 to the given integer...for each number
# 3. - DETERMINE if current number divides evenly into given integer
# ----- IF yes, add current number to 'results'
# ----- IF no, move on to next iteration
# 4. Return 'results'


def divisors(number)
  results = []
  
  1.upto(number) do |num|
    results << num if number % num == 0
  end
  
  results
end

p divisors(1) == [1]
p divisors(7) == [1, 7]
p divisors(12) == [1, 2, 3, 4, 6, 12]
p divisors(98) == [1, 2, 7, 14, 49, 98]
p divisors(99400891) == [1, 9967, 9973, 99400891] # may take a minute