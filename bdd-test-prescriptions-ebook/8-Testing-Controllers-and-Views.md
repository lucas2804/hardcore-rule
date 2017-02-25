#Testing Controllers and Views

- Prescription 20: A controller test should test controller behavior. A controller test should not fail because of problems in the model.

- Verifying Valid and invalid user request
- Verifying security

- 1. Expected: HTTP status code (response.status) or have_http_status matcher
- 2. Expected: render_template or redirect_to
- 3. Expected: Set view values as **assign, cookies, flash, session**

```ruby
it "shows a task" do
  task = Task.create!
  get :show, id: task.id
  expect(response).to have_http_status(:success) 
  expect(assigns(:task).id).to eq(task.id) 
  expect(session[:previous_page]).to eq("task/show")
end

```

##I - Simulating Request in a Controller Test

###1 - Simualate uploaded file

- In controller test: you be able to access to @request, @response, @controller, @request.headers

```ruby
post :create, logo: fixture_file_upload('/test/data/logo.png', 'image/png')
```

###2 - Makes an ajax call

- Meaning **.js** format blocks will be triggered.

```ruby
it "makes an ajax call" do
  xhr :post, :create, :task => {:id => "3"}
end
```

##II - Testing Routes(ignore)

##III - Testing Helper Methods

- **Helper methods** are disigned to contain resuable bits of view logic. 
- **Helper methods** aren't often test, even when they contain significant amounts of logic.
- Some helper methods have to dependencies on the real controller object there for **fail with opaque error messages during helper testing as url_for** (Workaround is override url_for).

##IV - Testing Views and View Markup 

###1 -  From a TDD perspective

- DO NOT write test for helper method, just insert the helper to the view template.
- DO NOT write test maybe the right choice when the test is **a) expensive, b(too normal), c) easy to detect if have an error** 

- Write an integration test using Capybara for outside-in(end to end) test.
- Write a Rails view test has the advantage as faster than integration test and we may be include it on existing controller tests.

- **Author Note(page 158)**: I reraly write these tests(view, helper). I find the file structure hard to maintain, an what logic I do have in views is often tested between objects like presenters and integration tests.
 
```ruby
# views/projects/index.html.erb_spec.rb
describe "project/index" do
  let(:completed_task) { Task.create!(completed_at: 1.day.ago, size: 1) }
  let(:on_schedule) { Project.create!(due_date: 1.year.from_now, name: "On Schedule", tasks: [completed_task]) }
  
  let(:incomplete_task) { Task.create!(size: 1) }
  let(:behind_schedule) { Project.create!(due_date: 1.day.from_now, name: "Behind Schedule", tasks: [incomplete_task]) }
  
  it "renders the index page with correct dom elements" do
    @projects = [on_schedule, behind_schedule]
    render # associate to project/index was mentioned in describe block.
    expect(rendered).to have_selector("#project_#{on_schedule.id} .on_schedule")
    expect(rendered).to have_selector("#project_#{behind_schedule.id} .behind_schedule")
  end
end
```
###2 - Stub helper methods in View test

- The helper methods are accessible via a **view object**
```ruby
view.stub(:current_user).and_return(User.new)
view.stub_template(filename: "", return_value: "")
```

- **Prescription 21: When testing for view elements, try to test for DOM classes that you control rather than text or element names that might be subject to design changes.**


##Testing Presenter

- As helpers, we will think about moving the logic from helpers in to presenters. This is especially true if you have a series of helpers that take the same argument

- Since our presenter class has no dependencies on Rails -> test class that also has no dependency on Rails
 
- We've given up a couple of things as **have selector** but we've gained something big:
    - 1) Cause this test has no dependecines on Rails, we don't need the Rails env
    - 2) Note that: **require "spec_helper"** that mean we be able execute the test without running Rails -> much faster
```ruby
# /app/presenters/project_presenter.rb
class ProjectPresenter < SimpleDelegator
  def self.from_project_list(*projects)
    # parse projects->presenter_projects
    projects.flatten.map { |project| ProjectPresenter.new(project) }
  end

  def initialize(project) 
    super
  end

  def name_with_status
    dom_class = on_schedule? ? 'on_schedule' : 'behind_schedule'
    "<span class='#{dom_class}>#{name} </span>'"
  end
end

# spec/presenters/project_presenter_spec.rb

require "spec/spec_helper"
describe ProjectPresenter do
  let(:project) { instance_double(Project, name: "Project Runway") } 
  let(:presenter) { ProjectPresenter.new(project) }
  it "handles name with on time status" do
    allow(project).to receive(:on_schedule?).and_return(true) expect(presenter.name_with_status).to eq("<span class='on_schedule'>Project Runway</span>") 
  end
  it "handles name with behind schedule status" do 
    allow(project).to receive(:on_schedule?).and_return(false) 
    expect(presenter.name_with_status).to eq("<span class='behind_schedule'>Project Runway</span>") 
  end
end

```

##V - Testing Mailers (http://github.com/bmabey/email-spec)

- Testing Rails mailers involves 2 separate bits of functionality:
    - 1) Specifying trigger, (Often exist in controller or integration test)
    - 2) Specifying content, (Often test subject, to, body)

- **Prescription 22: When testing a Boolean condition, make sure to write a test for both halves of the condition(True and False)**

- email-spec library provides a number of very useful helpers
```ruby
require 'rails_helper'
RSpec.describe TasksController, :type => :controller do 
  before(:example) do
    ActionMailer::Base.deliveries.clear
  end
  describe "PATCH update" do
    let(:task) { Task.create!(completed: false, title: "Write section on testing mailers", size: 2) } 
    
    # Falsy case
    it "does not send an email if a task is not completed" do
      patch :update, id: task.id, task: {size: 3}
      expect(ActionMailer::Base.deliveries.size).to eq(0)
    end
     
    # Truthy case 
    it "sends email when task is completed" do
      patch :update, id: task.id, task: {completed: true, size: 3}
      task.reload
      expect(task.completed_at).to be_present
      expect(ActionMailer::Base.deliveries.size).to eq(1)
      email = ActionMailer::Base.deliveries.first
      expect(email.subject).to eq("A task has been completed")
      expect(email.to).to eq(["monitor@tasks.com"])
      expect(email.body.to_s).to match(/Write section on testing mailers/)
    end
  end
end

# $ rails generate mailer TaskMailer
# /app/mailers/task_mailer.rb
class TaskMailer < ActionMailer::Base 
  default from: "from@example.com"
  def task_completed_email(task)
    @task = task
    mail(to: "monitor@tasks.com", subject: "A task has been completed")
  end 
end
```

##VI - Managing Controller and View Tests

- Should be isolated controller to model through stub/mock/ActionObject.
- ActionObject are usually wrap the logic of model, of valid object.










