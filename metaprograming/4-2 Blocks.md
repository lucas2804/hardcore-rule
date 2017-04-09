#Chapter 4: Blocks

##I - instance_eval()

- BasicObject#instance_eval, which evaluate a block in the context of an object:

```ruby

class MyClass
  def initialize
    @v = 1
  end
end

obj = MyClass.new

obj.instance_eval do
  self
  @v = 10 #Successfully change instance variable
end

obj #<MyClass:0x007f8b3c33d8e8 @v=10>
```

##II - instance_exec() : rarely use

```ruby
class C
  def initialize
    @x = 1
  end
end

class D 
  def my_method
    @y = 2 #@y depend on D
    
    #C.new : @y depend on C
    C.new.instance_eval {"@x: #{@x},@y : #{@y}"} 
  end
end

D.new.my_method #"@x: 1,@y : " 
```

- Can not bring **instance variable @y** into class C cause **instance variables depend on self**. 
- The code inside the block interprets @y as an instance variable of C.

- Let's fix it:
    1. This technique also known as **add instance_variables for another class** 
```ruby
class D 
  def my_method
    @y = 2 #@y depend on D
    
    #C.new : @y depend on C
    C.new.instance_exec(@y) {|y| "@x: #{@x},@y : #{y}"} #"@x: 1,@y : " 
  end
end

D.new.my_method # "@x: 1,@y : 2"

```

##III -  Callable Objects

- Where you learn how blocks are just part of a larger family, and show you how to set code aside and execute it later.

- The ideal: **Package code first, call it later**:
    1. In a proc, which is basically a block turned object
    2. In a lambda, which is a slight variation on a proc
    3. In a method
    
###3.1 - Proc Objects

- Although most things in Ruby are objects, **Blocks ARE NOT A OBJECT**
- A proc is a block that has been turned into an object

```ruby
####1 - Proc example
my_proc = Proc.new {|x| x + 1}
# Do bla bla bla bla

my_proc.call(2)               # => 3
my_proc.class                 # => Proc


####2 - Convert block to proc
def convert_block_to_proc(a, &proc)
  # &proc = block, so just drop & and you'll be left with a Proc
  proc.call
end

convert_block_to_proc(5) {puts "please call me to proc"}  

####3 - Convert proc to block

def convert_proc_to_block
  yield
end
my_proc = proc {"please convert me to block"}
convert_proc_to_block(&my_proc)

```

###3.2 - Procs, Lambdas and return

- In a Proc **return** returns the place where the object was called. In case it's place is main **LocalJumError was raise**

```ruby
my_proc = Proc.new {return 10}
my_proc.call                    #LocalJumpError cause self = main, and return does not make sense

my_lambda = lambda {return 10}
my_lambda.call                  #10 yey, it makes sense
``` 
 
- In a lambda, return just returns from the callable object's context.
  
###3.3 - Procs, Lambdas and Arity(Số tham số truyền vào)
  
- Lambdas are stricter, they do not accept wrong arity
  
```ruby
my_lambda = lambda {|var1, var2| return "#{var1} and #{var2}"}
my_lambda.call(5)     #ArgumentError: wrong number of arguments (given 1, expected 2)

my_proc = Proc.new  {|var1, var2|  "#{var1} and #{var2}"}
my_proc.call()        #" and "

```  

###3.3 - Procs, Lambdas and your decision
    
- Many rubyists use lambdas as a first choice cause they pretty strict about arity, and simply exit when you call return.        

###3.4 - Method Objects

```ruby

class MyClass
  def my_method
    puts "My method"
  end
end 

obj = MyClass.new
m = obj.method :my_method
m.call  #Yep just a callable object
```

##IV - Callable Objects Wrap-Up
    
- Callable objects are snippets of code that you can evaluate, and they carry their own scope along with them.
    1. Blocks (they aren't really "objects", but they are still "callable"): Evaluated in the scope in which they're defined.
    2. Procs: Objects of class Proc. Like blocks, they are evaluated in the scope where they're defined.
    3. Lambdas: also objects of class Proc but subtly different from regular procs.
        They're closures like blocks and procs, and as such they're evaluated in the scope where they're defined
    4. Methods: Bound to an object, they are evaluated in that object's scope. They can also be unbound from their scope and rebound to another object or class       

- Methods and Lambdas: **return** return from the callable object's context
    1. So methods and lambdas are stricter
- Block and Procs: **return** return from the place where object was called
    1. And Blocks and Procs more tolerant
    
- You can still convert from one callable object to another such as by using Proc.new, Method#to_proc, or **&** operator.
     
     
     
    



