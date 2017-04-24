#Models

##Reduce Large Transaction Blocks

- Large transaction blocks are often unnecessary because ActiveRecord supplies built-in transaction to wrap save process.


```ruby
#accounts_controller.rb
class AccountsController < ApplicationController
  def create 
    @account = Account.create_account(params[:account], params[:user])
    #...
  end
end

#account.rb
class Account < ActiveRecord::Base
  def create_account!(account_params, user_params)
    transaction do
      account = Account.create!(account_params)   #Crreate @account
      
      first_user = User.new(user_params)          # Refactor: accepts_nested_attributes_for :users
      first_user.admin = true                     # Refactor: before_create :make_admin_user
      
      first_user.save!                            #Save @user # Refactor: accepts_nested_attributes_for :users
      self.users << first_user                    # Refactor: accepts_nested_attributes_for :users
      
      account.save!                               #Save @account
      
      Mailer.deliver_confirmation(first_user)     # Refactor: after_create :send_confirmation_email 
      return account  
    end
  end
end

#The call back sequence occurs within transaction

before_validation
before_validation on: :create
after_validation 
after_validation on: :create
before_save
before_create
after_save
after_save
```

- This callback sequence often enables you to **avoid manually starting and programing your own transaction.**

```ruby
#Refactor1
#account.rb
accepts_nested_attributes_for :users

#views/accounts/_new.html.erb -> params[:account][:users_attributes][:username]

form_for(@account) do |form|
  fields_for :user, User.new do |user_form| 

  end
end

```

- After Refactor: you now no longer have the **create_account!** method. 
    1) Also notice that you no longer have to explicitly create a transaction
    
```ruby
class AccountsController
  def create
    @account = Account.new params[:account]
    if @account.save
    
    else
    
    end
  end
end
```    
