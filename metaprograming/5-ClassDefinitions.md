#Chapter5: Class Definitions

- In Java and C#: defining a class is like making a deal between you and the compiler.
    1. You'll say: "Here's how my objects are supposed to behave"
    2. And the compiler'll reply: "Okay, they will"
    
- In Ruby, class definitions are different, no compiler at all. When you use the **class** keyword, you're actually running code
    1. **Singleton classes** is most elegant features, an advanced topic, So understanding them will win you bragging rights among Ruby experts.
    

##I - Class Definitions
    
###1.1 - Inside Class Definitions    
- In fact, you can put any code you want in a class definition:
 
```ruby
class MyClass
  puts "Hello"
  return 10
end

obj = class MyClass
        puts "Hello"
        10
      end
obj # => "Hello" \n 10      
```

###1.2 - The Current Class

- As you know, wherever you are in a Ruby program, you always have a current_obj: self
- At the top level of your program: the current_obj is main, current_class is Object


###1.3 - class_eval()

- Module#class_eval evaluates a block in the context **of an existing class**.

```ruby
def add_method_a_class(class_name)
  class_name.class_eval do
    def buy_iphone
      puts "buy an iphone"
    end
  end
end

class MyClass

end

add_method_a_class(MyClass)
obj = MyClass.new
obj.buy_iphone # => "buy an iphone"

```

- instance_eval: only change self
- class_eval: changes both self and the current class
- and likely instance_exec: class_exec can pass an @instance_variable, parameters to the block

- If you're thinking "I want to open this object and I don't particularly care that it's class", instance_eval
- And if you're thinking "I want to OpenClass here", class_eval

###2.4 Current Class Wrap-up

- The Ruby interpreter always keeps a reference to the current class. All methods defined with def become instance methods of the current class

- In a class definition, the current object self and the current class are the same.

- If you have a reference to the class, you can open the class with class_eval or module_eval

###2.5 - Class Instance Variables

- The Ruby interpreter assumes that all instance variables belong to the current object self.

- You should sharply separate **instance variables** and **class instance variables**

```ruby
class MyClass
  @my_var = 1
  def self.read
    puts "object_id of @myvar in self context: #{@my_var.object_id}"
    @my_var #@my_var in self or MyClass scope
  end
  
  def read
    puts "object_id of @myvar in normal context: #{@my_var.object_id}"
    @my_var #@my_var in object scope
  end
  
  def write
    @my_var = 5
  end
end

obj = MyClass.new
obj.read                #object_id of @myvar in normal context: 8 --------- nil
MyClass.read            #object_id of @myvar in self   context: 3 --------- 1


obj.write
obj.read                #5 change @my_var of normal context
MyClass.read            #1 

```

###2.6 - Class Variables

- Class variables are different from Class Instance Variables because they can be accessed by
 subclasses and by regular instance method
```ruby
class C
  @@v = 1
end

class D<C
  def my_method
    @@v
  end
end

D.new.my_method # => 1
```

