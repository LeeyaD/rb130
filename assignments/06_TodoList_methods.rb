class Todo
  DONE_MARKER = 'X'
  UNDONE_MARKER = ' '

  attr_accessor :title, :description, :done

  def initialize(title, description='')
    @title = title
    @description = description
    @done = false
  end

  def done!
    self.done = true
  end

  def done?
    done
  end

  def undone!
    self.done = false
  end

  def to_s
    "[#{done? ? DONE_MARKER : UNDONE_MARKER}] #{title}"
  end

  def ==(otherTodo)
    title == otherTodo.title &&
      description == otherTodo.description &&
      done == otherTodo.done
  end
end

class TodoList
  attr_reader :todos
  attr_accessor :title

  def initialize(title)
    @title = title
    @todos = []
  end
  
  def add(todo)
    if todo.instance_of? Todo
      todos << todo
    else
      raise TypeError.new("Can only add Todo objects")
    end
  end
  alias_method :<<, :add

  def size
    todos.size
  end
  
  def first
    todos.first
  end

  def last
    todos.last
  end

  def to_a
    todos
  end

  def done?
    todos.all? { |todo| todo.done? }
  end
  
  def item_at(idx)
    todos.fetch(idx)
  end

  def mark_done_at(idx)
    todos.fetch(idx).done!
    # item_at(idx).done!
  end
  
  def mark_undone_at(idx)
    todos.fetch(idx).undone!
    # item_at(idx).undone!
  end

  def done!
    todos.each { |todo| todo.done! }
  end

  def shift
    todos.shift
  end

  def pop
    todos.pop
  end

  def remove_at(idx)
    todos.delete_at(idx) if self.item_at(idx)
  end

  def to_s
    puts "----#{title}----"
    todos.each { |todo| puts "#{todo}" }
  end

  def each
    @todos.each do |todo|
      yield(todo)
    end
    self
  end

  def select
    list = TodoList.new("Selected Todos")

    self.each do |todo|
      list << todo if yield(todo)
    end

    list
  end

  def find_by_title(title)
    select { |todo| todo.title == title }.first
    # item = nil
    # each do |todo|
    #   item ||= todo if todo.title == title
    # end
    # item
  end

  def all_done
    select { |todo| todo.done? }
  end

  def all_not_done
    select { |todo| !todo.done? }
  end

  def mark_done(title)
    find_by_title(title) && find_by_title(title).done!
  end

  def mark_all_undone
    each { |todo| todo.done! }
  end

  def mark_all_done
    each { |todo| todo.undone! }
  end
end

# todo1 = Todo.new("Buy milk")
# todo2 = Todo.new("Clean room")
# todo3 = Todo.new("Go to gym")

# list = TodoList.new("Today's Todos")
# list.add(todo1)
# list.add(todo2)
# list.add(todo3)

# p list.find_by_title("Clean room") == todo2
# p list.find_by_title("Wash car") == nil

# todo1.done!
# todo3.done!
# list2 = list.all_done
# p list2.object_id
# p list.object_id
# p list2.all_done.instance_of? TodoList

# list3 = list.all_not_done
# p list3.object_id
# p list3.instance_of? TodoList

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Buy milk")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

puts list
p todo1.object_id
p todo2.object_id

list.mark_done("Wash car")
puts list

list.mark_all_undone
puts list
list.mark_all_done
puts list

#mark_all_done - mark every todo as done
#mark_all_undone - mark every todo as not done