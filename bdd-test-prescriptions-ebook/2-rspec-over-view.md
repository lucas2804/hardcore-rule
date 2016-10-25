###**RSpec**

- RSpec is testing tool designed to support BDD rather than ->  RSpec use "_expect_" and "_describe_" suitable more than  "_test_" and "_assert_" in UnitTest.

![bdd-flow](./images/bdd-workflow.png)

```
rails g  rspec:install
    create .rspec   -> set color and auto require spec_helper
    create spec     -> folder contain spec
    spec_helper.rb  -> Rspec general settings
    rails_helper.rb -> settins depend on Rails, purpose write specs that do not load Rails.
```

####let(:me) let!(:you) syntax

- **Give**: Let's series are **definition space**

- **When**: action goes in before


######Always use _let_ to separate definition. 

```ruby
    # The same ideal except let defined with block
    let(:me) { User.new(name: "Lucas") } 
    expect(me.name).eq "Lucas"
    
    def me
      @me ||= User.new(name: "Lucas")
    end
    expect(me.name).eq "Lucas"
```

- Block after let isn't executed unless it's invoked
- Will not spend time to creating unused objects

```ruby
    describe "user behavior" do
      let(:me){ User.new(name: "Me") }
      let!(:you){ User.new(name: "You") }
      # false cause "me" still not evaluated
      # "let!(:you)" is invoked immediately count = 1
      specify { User.count.should == 2}
    end
```

####**Tricky**

```ruby
    def done? 
      task.empty? 
    end
    
    expect(project.done?).to be_truthy #absolutely right
    expect(project).to be_done #some magic, 1-done? -> be_done ... ahihi
```

####**Stub**

- Stub is a fake the call method that return a specified result.

####**Mock**

- Mock is a stub with an expectations that the method gets called.

###Use cases for Stub, Mock

- **Project has_many Task**: Some method from Task be able to break the test from Project
    -> Should use Stub/Mock Task to isolate Project

```ruby
def slice(*args)
  return nil
end
```




 

