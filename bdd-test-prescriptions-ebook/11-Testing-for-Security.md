#Testing for Security

- A good news is testing for security is easily reproducible in a test environment.
- The bad news is that you need to actively determine where access and injection bugs might lurk in your code.


##I - User Authentication and Authorization

- We can focus our attention on the security issues with **devise gem**
- Devise has some test helpers that we need to include in our controller tests.
```ruby
# rails_helper.rb
config.include Devise::TestHelper, type: controller
```

##II - Adding User And Roles

- **Prescription 25: Always do security testing in pairs: the BLOCKED LOGIC and the OKAY LOGIC**.

- Directly simulating a login(**log_in_as(user)**) has the benefits of exercising the real login page and making sure that the Devise is correctly. **It's an extra page load, so it's kind of slow**

- **In practice you should use the real login page at least once and stubs ones(stub(:current_user)).**

```ruby
# projects_controller_spec.rb
require "rails_helper"
describe "with users and roles" do
  def log_in_as(user)
    visit new_user_session_path
    fill_in("user_email", :with => user.email)
    fill_in("user_password", :with => user.password)
    click_button("Log in")
  end

  let(:user) { User.create(email: "test@example.com", password: "password") }

  # OKAY LOGIC
  it "allows a logged-in user to view the project index page" do
    log_in_as(user)
    visit(projects_path)
    expect(current_path).to eq(projects_path)
  end
  
  # BLOCKED LOGIC
  it "does not allow user to see the project page if not logged in" do
    visit(projects_path)
    expect(current_path).to eq(new_user_session_path)
  end
end
```

###2 - Warden for internal Rails methods as sign_in

-  We don't have **sign_in** method available cause it works at the internal Rails level. We can use **login_as_user(user)** instead helper provided by Warden.

- Login_as come from outside so we can use with integration_test, it looks faster.
 
```ruby
# spec/features/add_project_spec.rb
fixtures :all
include Warden::Test::Helpers
before(:example) do 
  login_as users(:user)
end
```

##III - Restring Access

- The next problem involves limiting access to only projects that the user is associated with.

```ruby
#spec/features/user_and_role_spec.rb
describe "roles" do
  it "allow a user... who is part of a project to see that project" do
    project.roles.create(user: user)
    login; visit; expect(current_path).to eq(project_path(project))
  end
  it "allow a user... who is part of a project to see that project" do
    login; visit; expect(current_path).to eq(project_path(project))
  end
end

```

- Than we drive the **Integration test** to **Controller test**

```ruby
describe "GET show" do
  # The same it method with integration test
  it "allow a user... who is part of a project to see that project" do
    controller.current_user.stubs(can_view?: true)
    get :show, id: project.id
    expect(response).to render_template(:show)
  end
  it "allow a user... who is part of a project to see that project" do
    controller.current_user.stubs(can_view?: true)
    get :show, id: project.id
    expect(response).redirect_to new_user_session_path
  end
end
```

- Than we drive the **Controller test** to **Unit test(model test)**
- **Stub(:current_user)** is a perfect use of mock objects. Because the detail of **can_view?** is complicate to set up and not suitable for behavior_test(controller_test). The test is also robust against future changes in the can_view? logic.

- **Prescription 28: Adding user authenticaton can be very disruptive to existing tests. Try to get the basic infrastructure in place early**








