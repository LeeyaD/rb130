# Write a program to determine whether a triangle is equilateral, isosceles, or scalene.

# An equilateral triangle has all three sides the same length.
# An isosceles triangle has exactly two sides of the same length.
# A scalene triangle has all sides of different lengths.

# Note: For a shape to be a triangle at all, all sides must be of length > 0, and the sum of the lengths of any two sides must be greater than the length of the third side.
=begin
PROBLEM
Create a program that determines whether a given triangle is equilateral, scalene, or isosceles.

input: 3 arg, the sides of the triangle

Notes:
- valid triangle: 
-- all 3 sides must be > 0
-- any two sides must be greater than the length of the 3rd side
- triangle types:
-- equilateral - all 3 sides are the same length
-- isosceles - eaxactly 2 sides are the same length
-- scalene - all sides are different lengths

EXAMPLES / TEST CASES
- need to create a Triangle class
--> incl. instance method #kind that returns a string value, the determined triangle type
--> initialized with 3 arguments which can be integers or floats
--> upon instantiation raise ArgumentError when
---- a triangle isn't valid
-----> all three sides are <= 0
-----> any two sides are less than the length of the 3rd side

DS
- Array
- Integers
- String

HINT
- constructor should validate triangle

ALGO, LS listed it by method within Triangle class
Constructor
- Save the three side lengths
- Check whether any side length is less than or equal to zero. If so, raise an exception.
- Use comparisons to determine whether the sum of any two side lengths is less than or equal to the length of the third side. If so, raise an exception.

Method: kind
- Compare the values representing the three side lengths
- If all three side lengths are equal return 'equilateral'.
- If the triangle is not equilateral, but any two side lengths are equal to one another, return 'isosceles'.
- If none of the side lengths are equal to one another, return 'scalene'.
=end

class Triangle
  attr_accessor :sides, :kind

  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
    validate_triangle
    @kind = determine_kind
  end

  def validate_triangle
    if sides_less_than_zero? || !two_sides_greater_than_one?
      raise ArgumentError, "This is not a valid triangle."
    end
  end

  def sides_less_than_zero? 
    sides.any? { |side| side <= 0 }
  end

  def two_sides_greater_than_one?
    sides[0] + sides[1] > sides[2] &&
    sides[1] + sides[2] > sides[0] &&
    sides[2] + sides[0] > sides[1]
  end

  def determine_kind
    return 'equilateral' if equilateral?
    return 'isosceles' if !equilateral? && isosceles?
    return 'scalene' if scalene?
  end

  def equilateral?
    sides.uniq.size == 1
  end

  def isosceles?
    sides.uniq.size == 2
  end

  def scalene?
    sides.uniq.size == 3
  end
end