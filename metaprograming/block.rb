# Block is not an object, SO we need Proc and Lambda
# Block is like an additional, an anonymous argument to a method
class Mage
  attr_accessor :name, :spell

  def enchant(target)
    puts "#{@name} casts #{@spell} on #{target.name}!"
  end
end

# ------------- BLOCK --------------
# 1 - my_method(free_param, *array_param, &block_param)
#     &block_param : Ruby will expect that is kind of "Block"
# 2 - yield : no need "&block" param
#     my_block.call <=> yield
# 3 - "block" are meant to be used "always together with methods"
#
def my_method(&my_block)
  puts "We're in the method, about to invoke your block!"
  my_block.call("Miracle", "Fuck it")
  puts "We're back in the method!"
end
#
# Explain: "run my_method" && "store put... into &my_block"
# Need 2 param "name && action" from "my_block.call('Miracle', 'Fuck it')"
my_method do |name, action|
  puts "We're in the block!!!!!"
  puts "Ask #{name} -- #{action}"
end

# Call my_method again, alternative way
my_method { |name, action|
  puts "We're in the block!!!!!"
  puts "Ask #{name} -- #{action}"
}
#
# Result
# "We're in the method, about to invoke your block!"
# "We're in the block!!!!!"
# "Ask Miracle  -- Fuck it"
# "We're back in the method!"
#
# Note:
# 1 - rails console
# 2 - type "Mage"
# 3 - Ruby will read all of things in mage.rb
#     if encounter the "block" "my_method do ... end"
#        Ruby will "execute" this block immediately

greeting = nil
my_method do
  greeting = "You can call me cause you've DEFINE me before"
  error_greet = "Will raise an error cause you NOT define me"
end
puts greeting     # Note: Unless with normal method, CAN NOT ACCESS param declared outsite
# puts error_greet  # NameError: undefined local variable or method `error_greet' for main:Object


# Ebooks Metaprograming
# 1) When blocks run, its need:
#   - local variables, instance variables, self, ...
# 2) Block contain:
#   - block of code, statements
#   - variables are binding(bind variables when define ablock)
#
def my_block1
  x = "Goodbye"
  yield "cruel"
end

x = "Hello" #binding x into my_block1
puts my_block1 {|y| "#{x}, #{y} world"}

#github.com/bbatsov/ruby-style-guide
# 4)Block is like an additional, an anonymous argument to a method
def math(a, b)
  yield
end

def do_math(a, b, &operation)
  math(a, b, &operation)
end

do_math(2, 3){|x, y| x * y }


