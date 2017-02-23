#Chapter7: Using Test Doubles as Mocks and Stubs

##I - We have some problems

- We want to add credit-card processing to our project: we dont want to depend on sandbox, depend on network call(slow), dont want our passing tests depend on status of a remote server.
- Another problem: we want to build a module that do not denpend on model/controller, this module should be isolated.

-> The solution to both of these problems is a test doubles, sometimes called a mock object.

- **Verifying the behavior of the system rather than the state of the system**


##II - Stub

###1) Stub

- A stub is a fake object that returns a predetermined value for a method call without calling the actual method on an actual object.

- **Stub**: "Ignore the real implementation of this method and return this value".
- **Mock**: "As Stub, and you have to call the method".

```ruby
allow(thing).to receive(:name).and_return("Fred")
expect(thing.name).to eq("Fred")
```

###2) Creating Stubs

- **full doubles**: Create entire objects that exist only to be stubs.
- **partial doubles**: Stub specific methods of existing objects.

- Prescription 15
```html
Use partial doubles when you want to ensure most of your real object behavior. 
Use full doubles when the behavior of the stubbed  object doesn't matter--only its public interface does
```

####2.1) Full Stubs

```ruby
it "can create doubles" do
  twin = double(first_name: "Paul", weight: 100) 
  expect(double.first_name).to eq("Paul")
end
```

####2.2) Partial Stubs

```ruby
# Stub a instance_method
it "stubs an object" do
  project = Project.new name: "Project Greenlight"
  allow(project).to receive(:name).and_return("Fred")
  expect(project.name).to eq("Fred")
end

# Stub a class_method: To avoid touching actual database(Slow)
it "stubs the class" do
  allow(Project).to receive(:find).and_return(Project.new(name: "Project Greenlight"))
  project = Project.find(1)
  expect(project.name).to eq("Project Greenlight")
end

# Stub Exception
it "Should be raise Exception" do
  user = User.new
  allow(user).to receive(:save).and_raise(InvalidUserException, "User is not valid")
end


# Do not use this feature if possible
it "Stub for any_instance_of Class" do
  allow_any_instance_of(Project).to receive(:save).and_return(false)
  project1 = Project.new
  project2 = Project.new
  expect(project1.save).to be_falsy
  expect(project2.save).to be_falsy
end
```


##III - Mock Expectations

- **Mock**: "As a stub, and you **have to call** the method".

```ruby
# 1 - Mock simple
it "Expects stuff" do
  mocky = double("Mock")
  expect(mocky).to  receive(:name).and_return("Paul")
  expect(mocky).to  receive(:weight).and_return(100)
  expect(mocky.name).to eq("Paul")
end

# This test fails:
#     ... Failure/Error: expect(mocky).to receive(:weight).and_return(100)

# 2 - Mock with Arguments
it "stubs the class" do
  allow(Project).to receive(:find).with(3).and_return(Project.new(name: "Project G"))
  project = Project.find 1
  expect(project.name).to eq("Project G")
#  Failure/Error: project = Project.find(1) ...
#                   .......................find with unexpected arguments
end
````

###1 - Using Mocks To Simulate Rails Save

- We should mock ActiveRecord#update-save to focus on main idea of controller_test(Which template should be rendered?) and speed up.

- **It's great if a bug appear, Our test just trigger in 1 place.**
- **speed up cause do not contact model(database)**


```ruby
it "fails create" do
  action_stub = double(create: false, project:Project.new)
  expect(CreatesProject).to receive(:new).and_return(action_stub)
  post :create, :project => {name: 'Project Runway'}
  
  # focus on response which template
  expect(response).to render_template(:new)
end

it "fails update gracefully" do
  project = Project.make() #stub
  expect(project).to receive(:update_attributes).and_return(false)
  allow(Project).to receive(:find).and_return(project)
  patch :update, id: sample.id, project: {name: "Fred"}
  
  # focus on response which template
  expect(response).to render_template(:edit)
end

```

- **Prescription 18: Nested mocks like code below is too pain. Instead do that, try to refactor your code to reduce dependencies.**

- **Prescription 19: Dont mock what you don't own as library, third party**

```ruby
it "don't do this" do
  fake_action = double(create: true, project: double(name: "Fred", tasks: [double(title: "Start", size: 2)]));
  # and so on... 
```

###2 - When to Mock, When to Stub

- **Stub** an object as an input of different process.
- **Mock** to verify the behavior of one part of the code.

- Mock use to isolate controller and model, it does mean that the controller test knows too much about your model than it otherwise might, ** which may make the model code harder to change**.

- **Pro tip**: should be careful side effects something like: saving to the database and outputting to the response stream are both side effects. (... hok hiểu lắm)

- Try to limit the number of mock methods in one test.
- A lot of mocks in one test indicate poor OOP where one class is asking for too many details of a different class.












