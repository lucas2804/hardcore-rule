# Block is not an object, SO we need Proc or Lambda to do this.
# ---------- Proc --------------
# 1) A Proc is a block that has been turned into an object
# 2) Execute Proc with Proc#call
# 3) &my_proc:
#         "& meaning is" I want to  take the block that is passed to this method and turn it into a Proc
#         just drop the &, and you'll be left with a Proc again
#
# -------------- Convert Block to Proc --------------------
# 1) define need to pass "&the_proc"
# 2) passing a block and drop "&"
def my_method1(&the_proc)     # Convert Block to Proc
  puts the_proc.call("Bill")  # Use as Proc, just drop "&" and you will receive the block
  puts yield("Bill")          # Use as Block
end
p = my_method1{|name| "Hello, #{name}!"}

# ---------- Convert Proc to Block and call with yield --------------
# 1) passing &my_proc as anonymous argument
# 2) yield
def my_method(greeting)
  "#{greeting}, #{yield}"
end

my_proc = proc {"Bill"}
my_method("Hello", &my_proc) # "Hello, Bill" -> Turn Proc to Block


# ----------------- Difference between Proc & Lambda --------
# The way that they will "return"

def double(callable_object)
  callable_object.call * 2
end

# l has (lambda) and p not
lamb = lambda {return 10}    # <Proc:0x007fa9af5b31e0@(irb):50 (lambda)>
proc = Proc.new {return 10}  # <Proc:0x007fa9ac2ead58@(irb):51>

double(lamb) # return 20
double(proc) # LocalJumpError cause proc try to "Return at top level", the program will return, stop, fail.


proc = Proc.new{10}
double(proc) # return 20

# Method is similar to a Block or a Lambda
# You can convert method to proc Method#to_proc
# vise versa "define_method" do ... end


# ----- SUMMARY ----------
# Callable objects are snippets of code that you can evaluate and they carry
# their own scope along with them.
# O: object; C: c
# 1 - Blocks:   NOT Objects, still Callable, Closure, Scope where they are defined
# 2 - Procs:    Are Objects, still Callable, Closure, Scope where they are defined
# 3 - Lambdas:  Are Objects, still Callable, Closure, Scope where they are defined
#               Diff with procs the way return
# 4 - Methods:  Diff with procs the way return
#               Bound to an object, Scope in object's scope
#               Unbound from their scope and "rebound" to another object
#
# 5) In methods, lambdas "return" word returns from the callable object
#    In procs and blocks "return" word returns from original context
#    -> methods & lambdas are almost as strict (should be used)

