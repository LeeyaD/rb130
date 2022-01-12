# Fill out the rest of the Ruby code below so it prints output like that shown in "Sample Output." You should read the text from a simple text file that you provide. (We also supply some example text below, but try the program with your text as well.)

# This question requires that you read a simple text file. Try searching the Web for information on how to do this, and also take a look at the File class in the Ruby documentation. If you can't figure it out on your own, don't worry: just put the data directly into your program; an Array with one element per line would be ideal.

# Read the text file in the #process method and pass the text to the block provided in each call. Everything you need to work on is either part of the #process method or part of the blocks. You need no other additions or changes.

# The text you use does not have to produce the same numbers as the sample output but should have the indicated format.

# HINT
# May assume that paragraphs have one empty line between them and that each line ends with a newline character. A single space appears between all words.

TEXT = "Eiusmod non aute commodo excepteur amet consequat ex elit. Ut excepteur ipsum
enim nulla aliqua fugiat quis dolore do minim non. Ad ex elit nulla commodo
aliqua eiusmod aliqua duis officia excepteur eiusmod veniam. Enim culpa laborum
nisi magna esse nulla ipsum ex consequat. Et enim et quis excepteur tempor ea
sit consequat cupidatat.

Esse commodo magna dolore adipisicing Lorem veniam quis ut labore pariatur quis
aliquip labore ad. Voluptate ullamco aliquip cillum cupidatat id in sint ipsum
pariatur nisi adipisicing exercitation id adipisicing qui. Nulla proident ad
elit dolore exercitation cupidatat mollit consequat enim cupidatat tempor
aliqua ea sunt ex nisi non.

Officia dolore labore non labore irure nisi ad minim consectetur non irure
veniam dolor. Laboris cillum fugiat reprehenderit elit consequat ullamco veniam
commodo."

class TextAnalyzer # sandwich code would have been to open/load & close the file!
  def process
    yield(TEXT)
  end
end

analyzer = TextAnalyzer.new
analyzer.process do |text| 
  para = text.split(/\n\s/).size # LS has /\n\n/
  puts "#{para} paragraphs"
end

analyzer.process do |text| 
  lines = text.split("\n").size
  puts "#{lines} lines"
end

analyzer.process do |text| 
  words = text.split(" ").size
  puts "#{words} words"
end

# Sample Output:
# 3 paragraphs
# 15 lines
# 126 words

