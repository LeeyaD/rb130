require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment #not asserting the output but that the amount paid was recorded
    transaction = Transaction.new(15)
    input = StringIO.new("25\n")
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal(25, transaction.amount_paid)
  end
end