# --------------- Pundit -------------------
# Pundit is a gem that helps define what permissions users have on resources as "policies"
#
# 1) G role.rb
# rails g model role role:string user:references project:references
# 2) rails g pundit:install # app/policies/application_policy.rb
# 3) include Pundit # into ApplicationController, avaiable to use authorize
# 4) rails g pundit:policy project
# 5) "ProjectController#show" authorize @project, :show do 2 things
#    - generate ProjectProlicy
#    - checkk ProjectPolicy::Scope::show?
def show
  authorize @project, :show?
end

# 6) "ApplicationPolicy::scope" is "Project" class
#    "ProjectPolicy#show?" override "Application#show?"
# def show?
#   # scope can be: Project, Ticket, User (model class)
#   scope.where(:id => record.id).exists?
# end

def show?
  record.roles.exist? user_id: user
end

# --------------- TEST Include helper to RSpec spec/support/authorization_helper.rb ---------------
# 1) require "pundit/rspec" to rails_helper.rb
module AuthorizationHelpers
  def assign_role!(user, role, project)
    Role.where(user: user, project: project).delete_all
    Role.create!(user: user, role: role, project: project)
  end
end

# tell RSpec to make AuthorizationHelpers available
RSpec.configure do |c|
  c.include AuthorizationHelpers
end

# uncomment rails_helper.rb to load file.
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

