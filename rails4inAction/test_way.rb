# 1)Features spec test:
# - Suitable testing a series of actions that user can perform in your app
#
# 2) Controller spec test:
# - Quickly testing singular points
# - allow:  fake method response from object
#           stubbing "current_user", wouldn't call current_user, instead return "user"
# allow(controller).to receive(:current_user).and_return(user)
# -> Faster, not side effect when login_as fail. (AND Warden Proxy not available in controller test -> login_as not available)
#
# 3) Fake WardenProxy in rails_helper.rb
# config.include Devise::Test::ControllerHelpers, type: :controller
# config.include Warden::Test::Helpers, type: :feature
# config.after(type: :feature) { Warden.test_reset! }

# ---------- UNIQUENESS EMAIL !IMPORTANT --------------
# in rails_helper, always rollback to clean state.
# config.use_transactional_fixtures = true

