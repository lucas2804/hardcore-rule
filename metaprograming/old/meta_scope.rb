# 1)The scope-variables can not be shared in program
v1 = 1
class MyClass           # SCOPE GATE: Open Class-Scope
  v2 = 2                  # => ["v2"]
  local_variables
  def my_method           # SCOPE GATE: Open Method-Scope
    v3 = 3                  # => [:v3]
    local_variables
  end                     # SCOPE GATE: Close Method-Scope
  local_variables         # => ["v2"]
end                     # SCOPE GATE: Close Class-Scope
obj = MyClass.new
obj.my_method
local_variables         # => [:v1, :obj]

# 2) How to share scope-local to Class or Method
# - With class use &block
# - With method absolutely use &block
# - Cause &block will bind local-variables at define block time.

my_var = "Success"
MyClass = Class.new do
  puts "my_var #{my_var} in the class definition!"

  define_method :my_method do
    "my_var #{my_var} in the method"
  end

  # ERROR
  # def my_method
  #   puts "#{my_var} ERROR"
  # end
end

