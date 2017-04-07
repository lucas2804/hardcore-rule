module MyModule
  MyConstant = 'Outer constant'
  class MyClass
    MyConstant = 'Inner constant'
  end
end

puts MyModule::MyClass::MyConstant #"Inner constant"
puts MyModule::MyConstant #"Outer constant"