# I - Objects
# 1)pointer to "1 instance_methods memory" (Share the same method)
# 2)clone memory to store "instance_variables" (Do not share instance_variables)
#
# II - Class
# 1)Reopen Class
# class D def y 'y'; end end
# class D def x 'x'; end end
# d = D.new  -> (d.x = 'x', d.y = 'y')
#
# II.1 - CONSTANT
# concept: start Uppercase as ABC or Abc
# 1) Will warning when reassign value (warning: previous definition of Abc was here)
# 2) Access as Module::MyConstant
# 3) Scope as file directory tree.
# module MyModule
#   MyConstant = 'Outer constant'
#   class MyClass
#     MyConstant = 'Inner constant'
#   end
# end
#
# puts MyModule::MyClass::MyConstant #"Inner constant"
# puts MyModule::MyConstant #"Outer constant"
#
# III - Module
# 0)Extend for class-method
# 1)Prepend priority more than itself
# 2)Ignore/Silently module if already exist
# module M1; end
# module M2
#   include M1 #ignore M1 cause appear once in "moduleM3"
# end
# module M3
#   prepend M1
#   include M2
# end
# M3.ancestors # => [M1, M3, M2]
#
#
# IV - self
# anytime you call a method, the object take the role of "self"
# 1)The Top Level
# - self # => main
# 2) self in class
# class MyClass
#   self # => MyClass
# end
#
# V - Refine
# 1) Refine not change global String Class
# 2) Refine need "using" statement to active
# module StringExtensions
#   refine String do
#     def reverse
#       "esrever"
#     end
#   end
# end
# module StringStuff
#   using StringExtensions
#   "my_string".reverse # => "esrever"
# end
# "my_string".reverse # => "gnirts_ym"






