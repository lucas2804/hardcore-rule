#Chapter6: Adding Data to Tests

##I - Preface

- Creating test data sounds like easiest thing ever. But to be useful the data should follow some criteria:
- 1) Should be able to create quickly and easily
- 2) Should be the same every time you generate (normaly, do not important)
- 3) Should be an accurate representation of the objects

- There are 2 techniques in the Rails community:
- 1) **fixtures**: fast, easy, global to all tests 
- 2) **factory(factory_girls)**: Use some variant on the factory design pattern to create data.
    Tradeoff: Can be slow to run.
    
##II - What's the Problem?

- We need to specify a known valid object where only place to update when new validations get created. **Fixture and factories** are 2 different mechanisms for solving this problem.

```ruby
# At very first time
it "can tell which user is older" do
  eldest = User.create(date_of_birth: '1971-01-22') 
  youngest = User.create(date_of_birth: '1973-08-31') 
  expect(User.find_eldest).to eq(eldest) 
  expect(User.find_youngest).to eq(youngest)
end

# Then you add some validations, some authentications...
# Too much painful if you have about 5 tests like that. 
it "can tell which user is older" do
  eldest = User.create!(date_of_birth: '1971-01-22',
                  email: "eldest@example.com", password: "password",
                  height: 185, zip_code: "60642", handedness: "left") 
  youngest = User.create!(date_of_birth: '1973-08-31',
                  email: "youngest@example.com", password: "password",
                  height: 178, zip_code: "60642", handedness: "ambidextrous") 
  expect(User.find_eldest).to eq(eldest) 
  expect(User.find_youngest).to eq(youngest)
end
```

##III - Fixtures(should not be used)

- If you are truly unit-testing, you likely don't need complicated object-relationship trees.
- Elseif you are acceptance-testing, you should be used **factory**

##IV - Factories(should be used)

- Factories are used to provide templates for creating valid objects.
- The Factory tool provide **blueprint** for creating a sample instance of your model.

```ruby
FactoryGirl.define do 
  factory :project do
    name "Project Runway"
    due_date Date.parse("2014-01-12") 
    slug { "#{name.downcase.gsub(" ", "_")}" }
  end
end

it "uses factory girl slug block" do
  project = FactoryGirl.create(:project, name: "Book To Write") 
  expect(project.slug).to eq("book_to_write")
end

# build_pair, create_pair, build_list, create_list
# create 2 objects
two_projects = FactoryGirl.create_pair(:project)

# create list objects
list_5_projects = FactoryGirl.create_list(:project, 5) 
````

###1) Basic Factory Creation
- 1) build(:project): return a model has not been saved to db
- 2) create(:project): return a model saved to db
- 3) attributes_for(:project): return a hash for passing ActiveRecord#new-create, useful for controller test.
- 4) build_stubbed(:project): ...

- When building the object from the factory, I consider it useful to explicitly list any attributes whose value is used in the test. **Even the attributes has the same value as the factory default**.

##V - Associations and Factories

###1) Factory and Problem of speed test.
- Should be noted that: even if you call the parent factory with build(task), the subordinate factory is still called with create(project, doer...) -> **this will be a big problem about speed test**.

```ruby
FactoryGirl.define do 
  factory :task do
    title: "To Something"
    size: 3
    project #called by default: FactoryGirl.create(:project)
    association :doer, factory: :user, name: "Task Doer" #custom association
  end 
end
FactoryGirl.build(:project)
# build 1 task, create 1 project, 1 doer

FactoryGirl.define do 
  factory :task do
    #...
    project #called by default: FactoryGirl.create(:project)
    association :doer, factory: :user, name: "Task Doer" #custom association
  end 
end
FactoryGirl.build(:project)
# build 1 task, create 1 project, build 1 doer
```

###2) Author's way to speed up.

- Page117: My preferred strategy is to not specify attributes in factories at all. I explicitly add them to the test at the point they're needed.

####Why?

- The best way to keep factory_girl from creating large object trees is to not define large object trees.
- Tests that require multiple degrees of associated objects often indicate bad code.

##VI - DRY Factories

###1) Sequences

- To prevent unique data as email_address, username, title ...

```ruby
FactoryGirl.define do 
  factory :task do
    #Task1 2 3 4 5
    sequence(:title) { |n| "Task #{n}" } 
    username
  end
end

```

###2) Inherited Factories

```ruby
FactoryGirl.define do 
  factory :task do
    sequence(:title) { |n| "Task #{n}" }
    factory :big_task do 
      size 5
    end
    factory :small_task do 
      size 1
    end 
  end
end

```

###3) Preventing Factory Abuse

- The best way to use factories is to create only the smallest amount of data needed to exppose the issue in each test. 
- 1) This practice speeds up the tests
- 2) Make the issue easy to see rather than put it among dozens of fixtures
- 3) Make the correctness of the tests easier to verify

####VII - Date and Times

###1) Using Relative Dates

```yaml
runway:
  name: Project Runway 
  start_date: <%= 1.month.ago %> # DO NOT use 2015-01-20

```

###2) Stubbing Time

- We often relative DateTime to current_date_time. So the solution for this is stub the current_date_time.
- The **travel_to(Date.parse("2015-02-10"))** me thod is effectively a super-specific mock-object. It stubs out **Date.today** and **Time.now** (travel_back to reset)

```ruby
it "finds recently started projects" do 
  travel_to(Date.parse("2015-02-10"))
  # Date.today = 2015-02-10
  actual = Project.find_recently_started(6.months) 
  expect(actual.size).to eq(3)
end

# &block version
it "reports based on start date" do 
  travel_to(Date.parse("2015-02-10")) do
    actual = Project.find_started_in_last(6.months)
    expect(actual.size).to eq(3)
  end 
end
```

###3) Comparing Time

- Comparing Date and DateTime will always fail.
- In general, using **to_s(:db)** it's a good idea to compare dates and times
```ruby
# 5.days.ago = Tue, 31 Jan 2017 12:09:56 UTC +00:00, 
# 5.days.ago.to_s(:db) = "2017-01-31 12:10:01" 
5.days.ago.to_s(:db)
```

###4) Setting Rails Timestamps

- **created_at**: should be set explicitly, because it will make some weird situations if the other dates in the test are explicitly set in the past.

- **updated_at**: can not set explicitly because Rails will automatically reset it on save. (Project.record_timestamps = true)

##VIII - Fixtures vs. Factories vs. Test Doubles

- One pattern for combining them is to create a complex scenario in fixtures for use in integration or complex controller tests, and to use factories for unit tests or simpler controller tests.




