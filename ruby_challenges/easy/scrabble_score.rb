=begin
Write a program that, given a word, computes the Scrabble score for that word.
Letter Values
A,E,I,O,U,L,N,R,S,T	> 1
D,G	> 2
B,C,M,P	> 3
F,H,V,W,Y	> 4
K	5
J,X	8
Q,Z	10

How to Score
Sum the values of all the tiles used in each word. For instance, lets consider the word CABBAGE:
3 + 1 + 3 + 3 + 1 + 2 + 1 = 14

PROBLEM
Given a word, compute the scrabble score. That is sum up each letters numeric value.
Letters that appear more than once still get scored.

EXAMPLES / TEST CASES
Create a Scrabble class with 3 methods
1. constructor method that takes 1 arg, a string, our given word
- doesn't raise an error
- given string is of any lenth and case insensitive
- nil and whitespace can be inputted
2. #score instance method that computes the scrabble score given when object is created
3. #score class method that takes 1 argument, a given word
-- computes the scrabble score without creating a scrabble object

Notes:
- 'nil' returns a score of 0
- an empty string returns a score of 0
- a string that only contains whitespace returns a score of 0

DS:
- Scrabble word, thereby input for constructor & the instance method #score are strings
- the score output is an integer
- consider a hash for the letters & their values
- may use an array for scoring

ALGO
- Create a Scrabble class
- Create a hash: keys are the letter values and values are an array of letters
- Create constructor method that takes 1 arg, saving it to an @var
-- VALIDATE input
--- Create a #valid_word? method
---- returns true or false depending on condition:
------ is scrabble word nil or empty when we strip all whitespace characers,
--- IF scrabble word is valid, save it downcased
----ELSE save an empty string

- Create #score instance method that takes no arg & COMPUTES the scrabble score
-- ADD a guard clause that returns 0 if the scrabble word is empty
-- CONVERT scrabble word into an array
-- ITERATE over array destructively, for current letter
----> SET a score var to nil
----> FIND & RETURN letter's value using the hash
------>> ITERATE thru hash key-value pairs (key: value, value: array of letters)
----------> CHECK if array of letters includes current letter
------------- IF so, set score var to key, otherwise do nothing
  ---->> put score var on last line in block
-- SUM & RETURN array of values

- Create #score class method that takes 1 argument, a scrabble word
=end

class Scrabble
  attr_reader :scrabble_word

  SCORE = {
    1 => ['A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'],
    2 => ['D', 'G'], 3 => ['B', 'C', 'M', 'P'],
    4 => ['F', 'H', 'V', 'W', 'Y'], 5 => ['K'],
    8 => ['J', 'X'], 10 => ['Q', 'Z']
  }.freeze

  def initialize(scrabble_word)
    @scrabble_word = scrabble_word
  end

  def score
    word = valid_input? ? scrabble_word.upcase : ''
    return 0 if word.empty?

    word.chars.map { |letter| return_value(letter) }.sum
  end

  def self.score(word)
    Scrabble.new(word).score
  end

  private

  def valid_input?
    !(scrabble_word.nil? || scrabble_word.strip == '')
  end

  def return_value(letter)
    score = 0
    SCORE.each do |value, letters|
      score = value if letters.include?(letter)
    end
    score
  end
end
