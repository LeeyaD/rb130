require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!


require_relative '03_TodoList'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end

  def test_size
    assert_equal(3, @list.size)
  end

  def test_first
    assert_equal(@todo1, @list.first)
  end

  def test_last
    assert_equal(@todo3, @list.last)
  end

  def test_shift
    todo = @list.shift                  # LS solution, more clear
    # assert_equal(@todo1, @list.shift)
    assert_equal(@todo1, todo)   # LS solution
    assert_equal(2, @list.size)  # My solution just tests the array size, doesn't confirm the right object was removed
    assert_equal([@todo2, @todo3], @list.to_a)  # LS solution  
  end

  def test_pop
    todo = @list.pop
    assert_equal(@todo3, todo)
    assert_equal([@todo1, @todo2], @list.to_a)
  end

  def test_done?    # LS calls this test `test_done_question`
    assert_equal(false, @list.done?)
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_raise_add_with_type    # LS calls this test `test_add_raise_error`
    assert_raises(TypeError) { @list.add("todo item") }
    assert_raises(TypeError) { @list.add(5) }
    error = assert_raises(TypeError) do
      raise TypeError, "Can only add Todo objects"
    end
    assert_equal("Can only add Todo objects", error.message)
  end

  def test_shovel_method    # LS calls this test `test_shovel`
    @todo4 = Todo.new("Do Laundry")
    @list << @todo4
    @todos << @todo4   # LS also had this
    # assert_equal(@todo4, @list.last)
    assert_equal(@todos, @list.to_a)   # LS solution
  end

  def test_add
    new_todo = Todo.new("Laundry")
    @list.add(new_todo)
    @todos << new_todo

    assert_equal(@todos, @list.to_a)
  end

  def test_item_at
    assert_raises(IndexError) { @list.item_at(8)}
    item = @list.item_at(1)
    assert_equal(@todo2, item)
    assert_equal(@todo1, @list.item_at(0))    # LS' solution
    assert_equal(@todo3, @list.item_at(2))
  end

  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(8)}
    @list.mark_done_at(0)
    assert_equal(true, @todo1.done?)
    @list.mark_done_at(2)
    assert_equal(true, @todo3.done?)
  end

  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_done_at(10)}
    @list.done!
    @list.mark_undone_at(2)
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end

  def test_done_exclamation
    @list.done!
    assert_equal(true, @list.done?)
  end

  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(10)}
    assert_equal(@todo1, @list.remove_at(0))
    setup
    assert_equal(@todo2, @list.remove_at(1))
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT

    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
    
    @todo1.done!
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<~OUTPUT.chomp
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT

    @list.done!
    assert_equal(output, @list.to_s)
  end

  def test_each
    array = []
    @todos.each { |todo| array << todo }
    assert_equal(array, @todos)
  end

  def test_each_return    # LS calls this test `each_returns_original`
    assert_equal(@todos, @todos.each { })
  end

  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)

    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
    refute_same(list, @list)
  end

  def test_todo_equality
    @todo4 = Todo.new("Buy milk")
    # result = @todo4 == @todo1
    # assert_equal(true, result)
    assert_equal(@todo4.title, @todo1.title)
  end
end