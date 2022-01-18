=begin
PROBLEM
Convert modern decimal numbers into their Roman number equivalent.
Don't need to worry about converting numbers over 3000.
I | 1
V | 5
X | 10
L | 50
C | 100
D | 500
M | 1000
* There's no symbol for zero
* Numeral placement within a number can sometimes indicate subtraction rather than addition

input: integer
output: string, roman numerals
Notes
- Don't worry about converting numbers over 3000
- Modern Roman numerals are written by expressing each digit of the number separately, starting w/ left most digit and skipping any digit with a value of zero

PROBLEMS / TEST CASES
- Create a class called RomanNumeral that has 2 methods
-- constructor w/ 1 arg, a decimal number
--- * doesn't raise any errors
-- #to_roman that converts decimal # to string roman numeral

DS
- input: integer; output: string
- hash for roman numerals & their values
- array for input integer

ALGO
- #initialize
-- take 1 integer arg & save it to an @var
-- don't raise any errors
- #to_roman
-- CONVERT value of @var to roman numeral & return roman numeral
-- 
=end


class RomanNumeral
  attr_reader :number

  DECI_TO_ROMAN = { 
    'M' => 1000, 'CM' => 900, 'D' => 500, 'CD' => 400,
    'C' => 100, 'XC' => 90, 'L' => 50, 'XL' => 40,
    'X' => 10, 'IX' => 9, 'V' => 5, 'IV' => 4, 'I' => 1 
                  }

  def initialize(number)
    @number = number
  end

  def to_roman
    numeral_str = ''
    number_clone = number.clone

    DECI_TO_ROMAN.each do |numeral, value|
      if value <= number_clone
        divisor, remain = number_clone.divmod(value)
        numeral_str << numeral * divisor
        number_clone -= value * divisor
      end
    end
    
    numeral_str
  end
end