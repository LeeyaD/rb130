=begin
Write a program that takes a word and a list of possible anagrams and selects the correct sublist that contains the anagrams of the word.

For example, given the word "listen" and a list of candidates like "enlists", "google", "inlets", and "banana", the program should return a list containing "inlets". Please read the test suite for the exact rules of anagrams.

PROBLEM
Given a word and a list of words, select words from the list that are anagrams of the given word.
An anagram is a word or phrase formed by rearranging the letters of a different word or phrase.
Ex. 'listen' > 'inlets'

EXAMPLES / TEST CASES
Create an Anagram class that gets initialized with one word
Class has 2 methods
- a constructur
-- requires 1 argument, the given word
-- doesn't raise an error
- an instance method, #match
-- requires 1 arg, the list of words in the form of an array of any length
-- returns an array of words from the given array that are anagrams of the given word
-- returns an empty array if no anagrams are found

Notes
! if word list contains given word (i.e. corn > [corn, CORN]), those don't count as anagrams (no rearranging was done)
! anagrams aren't case sensitive (i.e. Listen > Inlets (O))

DS
Given word is a string
List of words is an array
#match must return an array

=end

class Anagram
  attr_reader :given_word

  def initialize(given_word)
    @given_word = given_word # LS saved the argument in lowercase!
  end

  def match(list_of_words)
    formatted_word = format_to_compare(given_word)

    list_of_words.select do |word|
      anagram?(formatted_word, word) && !same_words?(word)
    end
  end

  private # LS made private all helper methods

  def format_to_compare(word)
    word.downcase.chars.sort!.join
  end

  def same_words?(other_word)
    given_word.downcase == other_word.downcase
  end
  
  def anagram?(word, other_word)
    word == format_to_compare(other_word)
  end

end