#Chapter 1: Models

- The Model:
 1) layer the core structure of your application
 2) The Model layer should also contain the business logic of your application
 3) In particular, It's incredibly important to have good unit test coverage of your model.
 4) Also cover many of the edge cases, prevent pitfalls that can occur in the Model layer of the application.
 
 
##AntiPattern: Voyeuristic Models (Kẻ hay tọc mạch vào models)

- **4 OOP core concepts**: encapsulation, modularity, polymorphism, inheritance.

- ActiveRecord: provides with its callbacks and validations and the structure and organization.
    1) So these powerful tools can be used to **break down** the principles of OOP
    2) Spiderman's uncle: "great power comes great responsibility"
    
###I - Solution: Follow the Law fo Demeter (1 dấu chấm)

####1 - Problems    
- It looks great: https://kipalog.com/posts/Nguyen-tac-Demeter-trong-huong-doi-tuong

```ruby
# Yep It looks normal for beginner
@invoice.customer.name
@invoice.customer.address.street
# ... over 100 lines use that coding style???
```

- **@invoice** should not arcoss the customer object than address object than call street.
    1) Some changes in the future: When the customer have billing_address and shipping_address, refactor all lines????
    
####2 - Law of Demeter
     
- Law of Demeter: **Use only one dot**.
 
```ruby
class Customer < ActiveRecord::Base
  has_one :address
  has_many :invoices
  
  delegate :street, :city,  :to  => address
end

class Invoice < ActiveRecord::Base
  belongs_to :customer
  delegate :street, :city, :to  => customer, :prefix => true
  
  def customer_billing_street
    puts "I separate this method to custom sth"
  end
end

@invoice.customer_street
@invoice.customer_city
@invoice.customer_billing_street
``` 

###III - Solution: Keep Finders on Their Own Model

```ruby
class UserController < ApplicationController
  def index 
    @user = User.find(params[:id])
    @memberships = @user.memberships.where(:active => true).limit(5).order("last_active_on DESC")
  end
end

#Refactor1: Move to model
class User < ActiveRecord::Base
  has_many :memberships
  def find_recent_active_memberships
    memberships.where(:active => true).limit(5).order("last_active_on DESC")
  end
end

#Refactor2: User know too much about Membership Model
class Membership < ActiveRecord::Base
  belongs_to :user
  scope :only_active, where(:active => true)
  scope :order_by_activity, order("last_active_on DESC")
end

class User < ActiveRecord::Base
  def find_recent_active_memberships
    memberships.only_active.order_by_active.limit(5)
  end
end
```

##AntiPattern: Fat Models

- Yep your Models are too fat: should simplifying the internal of a model by moving that complexity to new units: **modules and classes**

```ruby
# app/models/order.rb

class Order < ActiveRecord::Base
  #FIND
  def find_purchased
    # ...
  end
  
  def find_in_progress
    # ...
  end
  
  #SEARCH
  def self.simple_search
    # ...
  end
  
  def self.advanced_search
    # ...
  end
  
  #CONVERTER
  def to_csv
    # ...
  end

  def to_pdf
    #...
  end
end

#Refactor1 

class Order < ActiveRecord::Base
  extend OrderFinders
  extend OrderConverters
  include OrderSearchers
end

```

- **include**: puts the module's method on the calling class as **instance methods**.
- **extend**: makes them into **class method**


