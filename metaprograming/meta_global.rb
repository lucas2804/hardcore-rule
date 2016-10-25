# $global_variable: can access from all scope

def a_scope
  $var = "some value"
end
def another_scope
  $var
end
puts a_scope        #"some value"
puts another_scope  #"some value"
puts $var           #"some value"


puts a_scope.object_id        #70315145360820
puts another_scope.object_id  #70315145360820
puts $var.object_id           #70315145360820

# def a_scope
#   local_var = "some value"
# end
# def another_scope
#   local_var
# end
# puts a_scope        #"some value"
# puts another_scope  #"some value"
# puts local_var           #"some value"
#
#
# puts a_scope.object_id        #70315145360820
# puts another_scope.object_id  #70315145360820
# puts local_var.object_id           #70315145360820
#
