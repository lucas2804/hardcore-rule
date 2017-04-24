#Models Spaghetti SQL

- ActiveRecord is an incredibly powerful framework, and many new Rails developers fail to use it to their advantage
    1) You must take the time **to master the framework**.


###1 - Common mistake1: Model know implementation of another model

```ruby
class Pet < ActiveRecord::Base
  has_many :toys
  
  def find_cute_toys
    self.toys.where(cute: true) #know to much
    #refactor
    #self.toys.cute
  end
end
```

