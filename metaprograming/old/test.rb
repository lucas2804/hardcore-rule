class MyMethod
  @var = "Asd"

end
def double(callable_object)
  callable_object.call

end

p = Proc.new{return 10}

double(p)

