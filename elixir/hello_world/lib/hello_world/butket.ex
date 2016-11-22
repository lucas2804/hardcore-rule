defmodule HelloWorld.Bucket do

  def start_link do
    Agent.start_link(fn -> %{} end)
  end

  def get(bucket, key) do
    Agent.get(bucket, &Map.get(&1, key))
  end

  def put(bucket, key, value) do
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  # If there are too expensive actions to be done, you should be considered put it on client-side or server-side
  def delete(bucket, key) do
    Process.sleep(1000) # puts client to sleep
    Agent.get_and_update(bucket, fn dict ->
      Process.sleep(1000) # puts server to sleep
      Map.pop(dict, key)
    end)
  end
end