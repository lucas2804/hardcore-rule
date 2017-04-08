#Chapter 3: Tuesday: Methods

- Static languages as Java and C: The compiler checks to see that the receiving object has a matching method. This is called **static type checking**.
    1. - That's an important advantage of static type checking: the compiler can spot some of your mistakes before the code runs. 
    
- Dynamic languages as Ruby, Python.. don't have a compiler
    1. So you can call **my_unknown_method**, and your program just crash only it encounter that line and execute.

##I - A Duplication Problem

- Where you and Bill face a problem with duplicated code.

###Example: The Legacy System

- requirements: Lists all the components of each computer in the company and how much each component costs

```ruby
class Computer
  def initialize end
  def cpu_info end 
  def cpu_price end 
  def mouse_info end 
  def mouse_price end 
  #... a hundred of methods 
  #... a thoundsand of line
  # A terrible is encountered when you try to maintain
  # So you see that 1 convention appear here get_{@name}_info, get_{@name}_price
end
```

##II - Dynamic Methods

###1 - Refactor Computer Class with Dynamic Methods

```ruby
class Computer
  ComputerMethodNames = [:mouse, :cpu, :keyboard]

  def initialize() end
  
  for name in ComputerMethodNames 
    define_method("#{name}_info") do
      puts "Get info of #{name}"
    end
    
    define_method("#{name}_price") do
      puts "Get price of #{name}"
    end
  end
end

c = Computer.new
c.mouse_info 
```

###2 - Refactor Computer Class with method_missing

```ruby
class Computer
  def initialize() end
  
  def method_missing(name)
    if name.include?("_info")
      puts "Get info of #{name}"
    end
    
    if name.include?("_price")
      puts "Get price of #{name}"
    end
  end
end

c = Computer.new
c.mouse_info #Get info of mouse
```

- **method_missing** also known as Ghost Methods and dynamic proxies

####2.1 Ghost Methods (method_missing)

- **If they ask you something and you don't understand, do this**
- Ghost methods can be dangerous, the problem with Ghost Methods that they are not really methods
- **SO** Use Dynamic Methods if you can and Ghost Methods if you have to.

####2.2 Example you have to use Ghost Methods(method_missing)

- OpenStruct: http://ruby-doc.org/stdlib-2.0.0/libdoc/ostruct/rdoc/OpenStruct.html 

```ruby
icecream = OpenStruct.new
icecream.flavor = "strawberry"
icecream.color = "red"
icecream.i_dont_know = "the thing that I can not guess"
```