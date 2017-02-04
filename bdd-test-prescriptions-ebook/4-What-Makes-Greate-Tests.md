#What Makes Great Test

##I - Five Criteria to evaluate test quality(SWIFT)

- 1) [S]traightforward
- 2) [W]ell defined
- 3) [I]ndependent
- 4) [F]ast
- 5) [T]ruthful

###[S]traightforward

- A test is straightforward if its purpose immediately understandable.

```ruby
#Dont do this
it "should add to 37" do
 expect(User.all_total_points).to eq(37)
end

it "rounds total points to the nearest integer" do 
  User.create(:points => 32.1) 
  User.create(:points => 5.3) 
  expect(User.all_total_points).to eq(37)
end
```

###[W]ell defined

- A test is well defined if running the same test repeatedly gives the same result.
- Three classic causes of repeatability problems are time and date testing, random numbers, and third-party or Ajax calls.

- So we encapsulate the data by creating a **servie object** and stub/mock the output values.

###[I]ndependent

- A test is independent if it does not depend on any other tests or external data to run.
- If the application code is not well encapsulated it may be difficult or impossible to make the test fully independent

###[F]ast

- Slow test suites hurt you in a variety of ways.(I've run a test suite in 5 minutes, too much painfull).
- Test get slow for a number of reasons:
    1) Startup time
    2) Too much objects are created before.
    3) Use of the database or other external services.

- Best practices: **So Speeding tests up often mean** isolating application logic from the Rails stack. (Test without loading the entire Rails stack or without retrieving test data).    

###[T]ruthful

-  A truthful test accurately reflects the underlying code.

```ruby

# Dont
it "shows the project section" do
  get :dashboard
  expect(response).to have_selector("h2", :text => "My Projects")
end

# Should be
it "shows the project section" do
  get :dashboard
  expect(response).to have_selector("h2#projects")
end
```

##II - Using SWIFT Tests

- The goal of your test suite is to allow you to use tests to improve the design and for the existing tests. To empower you to make changes with less fear.

- Being strict about writing tests first, make the test simple and fast.


















