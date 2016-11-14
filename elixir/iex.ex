#################Part 1 ###################
run_query = fn(query_def) ->
    :timer.sleep(2000)
    "#{query_def} result"
end

# Create PID
spawn(fn -> IO.puts(run_query.("queryA")) end)

# Pass data to the created process
async_query = fn(query_def) ->
    spawn(fn -> IO.puts(run_query.(query_def)) end)
end

# After 2 seconds, print 5 query (Not 10 seconds)
Enum.each(1..5, &async_query.("query#{&1}"))


#################Part 2 ###################

run_query = fn(query_def) ->
    :timer.sleep(2000)
    "#{query_def} result"
end

async_query = fn(query_def) ->
    # Stores the PID of the calling process
    caller = self
    # Responds to the calling process
    spawn(fn ->
        send(caller, {:query_result, run_query.(query_def)})
     end)
end

# Run queries in 5 processes, and store the result into the mailbox(iex shell).
Enum.each(1..5, &async_query.("query #{&1}"))

get_result = fn ->
    receive do
        {:query_result, result} -> result
    end
end

# Get 5 results map with 5 queries
results = Enum.map(1..5, fn(_) -> get_result.() end)







