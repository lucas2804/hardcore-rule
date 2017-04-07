#Chapter 1
## The M World 

- Metaprograming is writing code that writes code

### I - Ghost Towns and Marketplaces

- Ghost towns(C++ Example): Once the compiler has finished its job, thing like variables and methods faded away, **runtime is an eerily quite place--a ghost town**.
    1. and runtime where you just have a bunch of **machine code** 

- In dynamic languages, such as Ruby, **runtime is more like a busy marketplace.** You can even reopen a class, a method and modify all of them.
    1. and runtime where you have most of construct, classes, methods, variables
    2. If you want to manipulate language constructs, those constructs must exist at runtime
    
### II - The Story of Bob, Metaprogrammer   

#### 1 - Bob's first attempt
```ruby
class Entity
    attr_reader :table, :ident
    def initialize(table, ident)
        @table = table
        @ident = ident
        Database.sql "INSERT INTO #{@table} (id) VALUES (#{@ident})"
    end

    def set(col, val)
        Database.sql "UPDATE #{@table} SET #{col}='#{val}' WHERE id=#{@ident}"
    end

    def get(col)
        Database.sql ("SELECT #{col} FROM #{@table} WHERE id=#{@ident}")[0][0]
    end
end

class Movie < Entity
  def initialize(ident)
    super "movies", ident
  end
  
  def title
    get "title"
  end
  
  def title=(value)
    set "title", value
  end  
end

```

- Yep, the above code looks good, Bob feels proud of himself
- But "There's a lot of duplication in this code"
    1. a *movies* table with a *title* column in the database
    2. a *Movie* class with an *@title*
    3. 2 *title* methods for get and set
    4. 2 *title* strings for detect which column
    
- `You can solve this problem with way less code if you sprinkle some metaprogramming over it`

#### 2 - Enter Metaprograming

- At the suggestion of his expert-coder friend(Bill). He finds that very thing in the **Active Record library**


```ruby
# rails g model movie title:string
class Movie < ActiveRecord::Base
  
end

movie = Movie.new
movie.title = "Maria"
movie.title # "Maria"
```

- So so so, no more code right? and how and where they defined?
- Yep: ActiveRecord reads the *schema.rb(Structure of database)* at runtime and defines accessor methods for title.
 
