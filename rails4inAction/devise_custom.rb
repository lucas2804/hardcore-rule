# 1) Custom condition for User's ability to sign_in
# Devise detect user be able to "sign_in or not" depend on "active_for_authentication?" in "user.rb"
# -> override to add more condition archived_at.nil?
def active_for_authentication?
  super && archived_at.nil?
end

# Condition to detect error message ":inactive" or ":archived"
def inactive_message
  archived_at.nil? ? super : :archived
end
# Custom message in devise.en.yml
# archived: "Your account has been archived"