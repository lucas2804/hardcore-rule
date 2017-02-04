##I - Test-Driven Rails

```html
A good test suite consists of a few end-to-end tests, a lot of unit tests.
```

```html
Requirements:
 • A user can create a project and seed it with initial tasks using the some- what contrived syntax of task name:size.
 • A user can enter a task, associate it with a project, and see it on the project page.
 • A user can change a task’s state to mark it as done.
 • A project can display its progress and status using the date projection we created in the last chapter.

```

###I.1 - Write Acceptance test first(End-to-end test)

####1 - Intro
- An Acceptance test as a test case of QA.
- When write end-to-end test, The goal is to have the success criteria be **based on visible thing in a response** rather than checking the database to see if the object is created.

####2 - Several reasons
- There are several reasons why it's valuable to have a test like this one:
1) It forces us to think of our feature in terms of behaviors(Not all features have UI, but where they do, we will always specify the correct behaviors)
2) Eventually, We still need a test that can cover a group of unit-test to prevent bugs between unit-test.

##II - Automation test Example.

####1 - Write acceptance test first

- Force us to think about a behavior of this feature(BDD)

```ruby
describe "adding projects" do
  it "allows a user to create a project with tasks" do
    visit new_project_path
    fill_in "Name", with: "Project Runway"
    fill_in "Tasks", with: "Task 1:3\n Task 2:5"
    click_on "Create Project"
    visit projects_path
    expect(page).to have_content("Project Runwa")
    expect(page).to have_content("8")
  end
end
```

####2 - Test kind of controller, business logic

- Three locations are commonly used for business logic that responds to user input(pass the params hash to ActiveRecord#create)
1) Put the extra logic **in the controller**. This is Rails core team's preferred method.(The author feel right 60% page 60/342)
2) Put the extra logic **in the model**. Make model fat, more complicated(70%)
3) **Break business logic from controller to a class which** encapsulate the logic and workflow(90%). In this case, We will have a lot of little classes but never mind.

#####2.1 Example for case 3: Break logic from controller to another class.
```ruby
# Conventions: CreatesProject or CreateProject, ProjectCreator, ProjectFactory...
class CreatesProject
    attr_accessor :name, :task_string, :project
    def initialize(name: "", task_string: "") 
      @name= name
      @task_string = task_string
    end
    
    def build
      self.project = Project.new(name: name) 
    end
    
    def create 
      build
      project.save
    end
end

# spec/actions/creates_projects_spec.rb: Test action create project
describe "task string parsing" do
  let(:creator) { CreatesProject.new(name: "Test", task_string: task_string) } 
  let(:tasks) { creator.convert_string_to_tasks }
  describe "with an empty string" do 
    let(:task_string) { "" }
    specify { expect(tasks.size).to eq(0) }
  end
end
```
####2.2 - Controller testing(make speed of test is slower)

- As we break out business to **CreatesProject**, we can **test failure cases** in **CreatesProject** instead **ProjectsController**.
- We will gain from reduce complexity in **ProjectsController**. Faster test because in controller test we have to fake HTTP-Object for request and response.

- **Note, The controller for success test cases**: The controller test needs to test only the behavior of the controller itself. The fact that the controller uses correct params as expected (Success test cases)

```ruby
# spec/controllers/projects_controller.rb:
# Rspec ignore router.rb do not map HTTP method as "post, get, delete, put..." So it just a readable name
# assigns(:action) <=> @action from controller(reference to )
RSpec.describe ProjectsController, type: :controller do
  describe "POST create" do 
    it "creates a project" do
      post :create, project: {name: "Runway", tasks: "Start something:2"} 
      expect(response).to redirect_to(projects_path) 
      expect(assigns(:action).project.name).to eq("Runway")
    end 
  end
end

# app/controllers/projects_controller.rb
def create
  @action = CreatesProject.new(name: params[:project][:name],task_string: params[:project][:tasks])
  @action.create
  redirect_to projects_path
end
```

####3 - Failure tests

- **I prefer to do failure testing in unit tests(as model or another class like CreatesProject) rather than end-to-end tests(page 68)**

####Test Prescription 7



