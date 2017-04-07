

def index_for( word )
  %w{ Mary had a little lamb }.find_index { |this_word|   word == this_word }
end

index_for("zzxczxc")