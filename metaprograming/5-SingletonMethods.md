#Chapter5: Class Definitions

##I - Singleton Methods

```ruby
class Paragraph
  def initialize text
    @text = text
  end

  def title?
    @text.upcase
  end
end

``` 

- If Paragraph#title? is called only once?? and **Paragraph Class is kind of stupid** cause it's just a regular **String**.

- How about Monkeypatch **String class**? For use it just once time, and it's just make sense for **Paragraph** it's not make sense for entire **String** class.

###1.1 Yep, Singleton methods were born for resolve kind of stupid

- **Object#singleton_methods** : Ruby allows you to add a method to a single object.

```ruby
paragraph = "My name is Title"

def paragraph.title?
  self.upcase == self
end

str.title?                  # => false
str.singleton_methods       # => [:title?]
str.methods.grep(/title?/)  # => [:title?]

```

##II - Duck Typing

- Some people are horrified Singleton Methods, it makes your code become spaghetti, right?

- If you reacted that way yourself, then you should be backed to static language

- In a dynamic language such as Ruby: the **type** of an object is not strictly. Instead check type of an object, Ruby check  
    1. People refer to call it such as **Duck Typing**
    2. If it walks like a duck and quacks like a duck, then it must be a duck
    3. In other words, you dont care about that obj is baby of Duck, you just care this obj can **walk and quack**

- If you get used to duck typing and after learning a few cool dynamic tricks, **you might even wonder how you could have lived without it in the first place.**
   
##III - Class Methods and Singleton Methods are the same
   
```ruby
class MyClass
  attr_accessor :miracle
  def self.my_class_method1
    puts "Class Method1 created by normal way"
  end
end

def MyClass.my_class_method2
  puts "Class Method2 crated by singleton method way"
end

MyClass.methods.grep(/my_class_method.*/) # => [:my_class_method1, :my_class_method2]
```   

##IV - Class Macros

- **Module#attr_reader , attr_accessor, attr_writer** are kind of **Class Macros**

##V - Home of Singleton Classes?

- You'll notice that there's no obvious home for my_single_ton_method there
    1. The SM can't live in obj because obj is not a Class
    2. It can't live in Class because all instances of Class would share it
    3. It can't be an in Class.superclass
    
- Yep, Ruby is liar. When you ask an object for its class, Ruby doesnt always tell you a whole truth.
- An object has own special **hidden class** that also known as **singleton class**

```ruby

```

    



