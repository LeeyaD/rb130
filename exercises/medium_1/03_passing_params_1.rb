# Modify the method below so that the display/output of items is moved to a block, and its implementation is left up to the user of the gather method.

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "Nice selection of food we have gathered!"
end

# gather(items) { |items| puts "#{items.join(', ')}" }
# we're calling #puts no need for string interpolation

gather(items) { |items| puts items.join(', ') }