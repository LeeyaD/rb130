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
    puts "#{self.item_at(idx)} has been marked done!"
  end

  def mark_undone_at(idx)
    todos.fetch(idx).undone!
    puts "#{self.item_at(idx)} has been marked not done."
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
    counter = 0
    while counter < todos.size do
      yield(todos[counter])
      counter += 1
    end
  end

  # def each
  #   @todos.each do |todo|
  #     yield(todo)
  #   end
  # end
end

todo1 = Todo.new("Buy milk")
todo2 = Todo.new("Clean room")
todo3 = Todo.new("Go to gym")

list = TodoList.new("Today's Todos")
list.add(todo1)
list.add(todo2)
list.add(todo3)

list.each do |todo|
  puts todo                   # calls Todo#to_s
end
