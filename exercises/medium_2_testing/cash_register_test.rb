require 'minitest/autorun'
require 'minitest/reporters'
Minitest::Reporters.use!

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @register = CashRegister.new(100)
    @balance = @register.total_money
    @transaction = Transaction.new(11.30)
    @transaction.amount_paid = 30
  end

  def test_accept_money
    @register.accept_money(@transaction)
    new_balance = @balance + @transaction.amount_paid
    assert_equal(new_balance, @register.total_money)
  end

  def test_change
    exp_change = @transaction.amount_paid - @transaction.item_cost
    assert_equal(exp_change,@register.change(@transaction))
  end

  def test_give_receipt
    output = "You've paid $#{@transaction.item_cost}.\n"
    assert_output(output) {@register.give_receipt(@transaction)}
  end
end