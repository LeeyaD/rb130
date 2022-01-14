require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'text.rb'
require_relative 'sample_text.rb' # don't need b/c of line 10

class TextTest < Minitest::Test
  def setup
    @file = File.open("sample_text.rb")
    @text = Text.new(@file.read)
  end

  def test_swap
    swapped_text = @text.swap('a', 'e')
    assert_nil(swapped_text.gsub!('a', 'e'))
  end

  def test_word_count
    act_count = @text.word_count
    exp_count = @text.text.split(/\s/).count
    assert_equal(exp_count, act_count)
  end

  def teardown
    @file.close
    puts "File has been closed: #{@file.closed?}"
  end
end