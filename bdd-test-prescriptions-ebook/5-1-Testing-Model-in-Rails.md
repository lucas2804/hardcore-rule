#Testing Models

##V - Testing What Rails Gives You

###1) Sementics
- Rails provides built-in functionality for associations and validations(belongs_to, presence...). Which leads to questions about how to effectively and usefully test those features in your application.
- The answer in both cases is similar, and goes back to **the basic principle that we're testing functionality and not implementation**

###2) Practices:
- If you're doing TDD process, you shouldn't start from the idea that your Task belongs to a Project. Rather, as you describe features the relationship is implied from the feature tests that you're writing
- I think you can make validations in your code work efficiently with the TDD process if you **focus on the functional part--"this object is valid"** versus "this object is not"
```ruby
# Implementation test: Should be not used
describe Task do
  it{ should belong_to(:project) }
  it{ should ensure_presence(:name) }
end

# Feture test: Should be used
it "does not allow creation of a tesk without a name" do
  task = Task.new(name: "search a book", size: 5)
  expect(task.size).to be_presence
end
```

##VI - Tesing ActiveRecord Finders

###1) Sementics

- ActiveRecord can be composed as: Task.where(status: completed).order("completed_at DESC").where("size > 3").

###2) Practices

- If a finder is extracted during refactoring and an existing test already covers its functionality. You may not need a new test to cover it. Like any other method extracted in refactoring, you're not adding logic.

- You need to create some objects from DB to feel confident when test which makes the test slow.
**So we should be created as few objects as possible for the speed**.

- If I need to test sort logic. I create three objects: low value, middle value, high value.
- If you are testing a method that finds objects based on criteria, start with a test that creates two objects. That's one object you expect and one that you do not.

```ruby
it "finds completed tasks" do
  complete = Task.create(completed_at: 1.day.ago, title: "Completed task")
  incomplete = Task.create(completed_at: nil, title: "Not completed task")
  expect(Task.complete.map(&:title)).to  eq(["Completed task"])
end
```

##VII - Testing shared modules and ActiveSupport Concerns

- If the shared feature depends on data available in each class, **that dependency is testable logic**.
- **shared example** is used to run the same set of specs in multiple describe blocks.
- **shared example** must be defined in "spec/support" before they are used.

```ruby
# spec/support/size_group.rb
# should not be used(will failed)
# 1 - Can not create instance from module_name: So we will use described_class which is the class referenced 
#     let(:instance) {described_class.new(size: 1)}
# 2 - Should mock the size because: Task.size(init) and Project.size(through task.size)
Rspec.shared_examples "sizeable" do
  let(:small_size) {Sizeable.new(size: 1)}
  let(:epic_size) {Sizeable.new(size: 5)}
  
  it "knows a 1 point story is small" do
    expect(small_size).to be_small
  end
  
  it "knows a 5 points story is epic" do
    expect(epic_size).to be_epic
  end
end

# should be used
Rspec.shared_examples "sizeable" do
  let(:instance) {described_class.new(size: 1)}
  
  it "knows a 1 point story is small" do
    allow(instance).to receive(:size).and_return(1)
    expect(instance).to be_small
  end
  
  it "knows a 5 points story is epic" do
    allow(instance).to receive(:size).and_return(5)
    expect(instance).to be_epic
  end
end

# spec/models/task_spec.rb
RSpec.describe Task do
  it_should_behave_like "sizeable"
  #...
end
```

##Write Your Own RSpec Matchers(I'm not interested)


