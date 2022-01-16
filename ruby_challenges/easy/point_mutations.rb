# Write a program that can calculate the Hamming distance between two DNA strands.
# By counting the number of differences between two homologous DNA strands taken from different genomes with a common ancestor, we get a measure of the minimum number of point mutations that could have occurred on the evolutionary path between the two strands.

# This is called the Hamming distance.
# GAGCCTACTAACGGGAT
# CATCGTAATGACGGCCT
# ^ ^ ^  ^ ^    ^^

# The Hamming distance between these two DNA strands is 7.

# The Hamming distance is only defined for sequences of equal length. If you have two sequences of unequal length, you should compute the Hamming distance over the shorter length.
=begin

PROBLEM
Calculate the 'Hamming Distance' between two DNA strands.

input: 2 arrays of varying lengths
output: integer (hamming distance)

Notes:
- Hamming Distance: the number of differences between 2 DNA strands (i.e. the # of times a point in both strands is not the same; A == A, but A != C)
- 2 sequences of unequal length? Compute the Hamming distance over the shorter length

EXAMPLES / TEST CASES
We'll need to create a class called 'DNA'

Constructor
- takes 1 argument, string that rep a DNA strand
# LS > contructor doesn't raise any errors

Methods
- instance
-- #hamming_distance takes 1 arg, the second DNA strand & returns the hamming distance

DATA STRUCTURES
string, array, integer

ALGO
- create a class with one attribute, 'dna' that we can read
- create constructor w/ 1 argument & sets it to 'dna' attribute
- create a #hamming_distance instance method that takes 1 argument, 'dna2'
-- first check size of dna & dna2
--- if they're equal, DETERMINE hamming_distance
----- create counter
----- iterate thru dna, for current point
------- IF curr_point & same point in dna2 are different, increase counter by one
------- ELSE do nothing
--- if they're not of equal length, DETERMINE which strand is shorter
----- check is dna is less than dna2 in length
------- IF that's true, dna is the shortest; otherwise, dna2 is the shortest
----- iterate thru the shortest strand, for current point
------- IF curr_point & same point in dna2 are different, increase counter by one
------- ELSE do nothing
-- return counter
=end

class DNA
  attr_reader :dna

  def initialize(dna)
    @dna = dna
  end

  def compare_length(other_dna)
    dna.size < other_dna.size ? [dna, other_dna] : [other_dna, dna]
  end

  def hamming_distance(other_dna)
    counter = 0
    length1, length2 = compare_length(other_dna)

    length1.chars.each_with_index do |point, idx|
      counter += 1 if point != length2[idx]
    end

    counter
  end
end