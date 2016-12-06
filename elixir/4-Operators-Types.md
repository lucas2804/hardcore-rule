####Anonymous functions

- Anonymous functions can access **environment variables** but can not modify them

```elixir
x = 42
can_not_modify_x = fn -> x = x + 12 end
can_not_modify_x.() # 54
x # 42
# -> Can access but can NOT modify
```

```ruby
x = 42
can_modify_x = Proc.new {x = x + 12}
can_modify_x.call # 54
x # 54
# -> Can access and modify x
```

####Linked Lists

- As linked list in C++, 1 node contain **a value** and **a pointer**. Start with pointer head and stop with pointer tail.

```elixir
list = [1 | [2 | [3 | []]]]
[0 | list] # [0, 1, 2, 3] 

# tuples as hash in Ruby
list_tuples = [a: 1, b: 2]
list_tuples ++ [c: 5]

```

####Maps

```map as hash
new_map = %{a: 1, b: 3}
%{:a => 1, :b => 5} == %{a: 1, b: 5}
```







