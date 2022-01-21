# Write a program that can generate the lyrics of the 99 Bottles of Beer song. See the test suite for the entire song.
# 2 bottles of beer on the wall, 2 bottles of beer.
# Take one down and pass it around, 1 bottle of beer on the wall.

# 1 bottle of beer on the wall, 1 bottle of beer.
# Take it down and pass it around, no more bottles of beer on the wall.

# No more bottles of beer on the wall, no more bottles of beer.
# Go to the store and buy some more, 99 bottles of beer on the wall.

# PROBLEM
# Write a program that can output the lyrics to the 99 Bottles of Beer song

# EXAMPLES / TEST CASES
# Need a BeerSong class with 3 methods
# - a class method, #verse, 
# -- that can take 1 argument, a number
# -- & outputs the corresponding verse in the song
# --> 99 first verse, 0 the last verse, 1 the 2nd to last, 

# - a class method, #verses
# -- that can take 2 arguments, numbers
# -- & outputs the corresponding verses in the song
# --> 99,98 the 1st & 2nd verses, 2,0 verses 2 thru 0

# - a class method, #lyrics that outputs the entire song from 99 through 0

# DS
# input into #verse and #verses are numbers
# ouput for all methods are strings

# ALGO
# create a helper method  that outputs the verse when there's 0 bottles of beer left
    # No more bottles of beer on the wall, no more bottles of beer.
    # Go to the store and buy some more, 99 bottles of beer on the wall.
# create a helper method that outputs the verse when there's 1 bottle of beer left
    # # 1 bottle of beer on the wall, 1 bottle of beer.
    # Take it down and pass it around, no more bottles of beer on the wall.
# #verse, create a method that takes 1 arg, 'number'
# - GENERATE a verse from the song based on the given number
# -- IF the number is 0 or a 1, call helper methods and end method, otherwise
# -- output 2 strings w/ interpolation
# -- 1) n bottles of beer on the wall, n bottles of beer.
# -- 2) Take one down and pass it around, n-1 bottle of beer on the wall.

class BeerSong
  def self.verse(n)
    case n
    when 0
      return zero_bottles
    when 1
      return one_bottle
    when 2
      return two_bottles
    end
    "#{n} bottles of beer on the wall, #{n} bottles of beer.\n" \
    "Take one down and pass it around, #{n-1} bottles of beer on the wall.\n"
  end

  def self.verses(first_num, last_num)
    lyric = (last_num..first_num).map do |num|
      verse(num)
    end
    lyric.reverse.join("\n")
  end

  def self.lyrics
    verses(99, 0)
  end

  class << self
    private
    def zero_bottles
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  
    def one_bottle
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    end
  
    def two_bottles
      "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    end
  end
end