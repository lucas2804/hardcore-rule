##OTP Applications

- OTP(Open Telecom Platform): is a set of libraries that ships with Erlang. Including supervision trees, event managers and more.
 
- Mix  is a build tool that ships with Elixir that provides tasks for crating, compiling, testing your application, managing its dependencies and much more;
 
- ExUnit is a test-unit based framework that ships with Elixir.

###Concepts

1) Processes
2) Agent        : Simple wrappers around state 
3) GenServer    : **Generic servers** (processes) that encapsulate state, provide sync and async calls, support code reloading, and more
4) GenEvent     : **Generic Event** managers that allow publishing events to multiple handlers.
5) Task         : Asynchronous units of computation that allow spawning a process and potentially retrieving it's result at a later time
 
###I - Processes

1) Isolated and do not share anything. 
2) Processes communicate together through singleton mailbox. All message locate in mailbox.
3) Processes are linked to **supervisor** to detect fail processes to re-run
4) **flush** to print all the message in the mailbox
- A message can be anything, a string, a PID, a number... {:hello_key, self()} or {:hello_key, "I am a message"} and #{inspect msg} can be "I am a message" or #PID<0.148>

####Processes loop infinitely to maintain

```elixir
defmodule HelloWorld do
  def start_link do
    Task.start_link(fn -> loop(%{}) end)
  end

  defp loop(map) do
    receive do
      {:get, key, caller} ->
        send caller, Map.get(map, key)
        loop(map)
      {:put, key, value} ->
        loop(Map.put(map, key, value))
    end
  end
end

{:ok, pid} = HelloWorld.start_link 
send pid, {:put, :hello, :world}
send pid, {:get, :hello, self()} #{:get, :hello, #PID<0.12>}
```

###II - Agent

- Agents are processes, each bucket has a PID but it does not have a name.
- We can name for an agent, But **we should never convert user input to atoms** because atoms are not garbage collected, never reclaimed, increase system memory.
```elixir
Agent.start_link(fn -> %{} end, name: :shopping)
```
- The **registry** each bucket needs to **monitor** 
```elixir
iex(1)> {:ok, pid} = KV.Bucket.start_link
{:ok, #PID<0.120.0>}
iex(2)> Process.monitor(pid)
#Reference<0.0.3.846>
iex(3)> Agent.stop(pid)
:ok
iex(4)> flush
{:DOWN, #Reference<0.0.3.846>, :process, #PID<0.120.0>, :normal}

```

```elixir
{:ok, pid} = Agent.start_link(fn -> %{} end)
Agent.update(pid, fn map -> Map.put(map, :hello, :world) end)
Agent.get(pid, fn map -> Map.get(map, :hello) end)
```

```elixir
{:ok, agent} = Agent.start_link fn -> [] end
Agent.update(agent, fn list -> ["eggs" | list] end)
Agent.update(agent, fn list -> ["beef" | list] end)
Agent.get(agent, fn list -> list end)#["eggs", "beef"]
```

###III - GenServer

- A GenServer is implemented in two parts: 
    1) the client API 
    2) and the server callbacks
- There are 2 types or request: **sync-call** and **async-cast**

####call, cast or info?

- **handle_call/3**: sync requests
- **handle_cast/2**: asyn requests, when you dont care about reply.
- **handle_info/2**: Must be used for all other messages a server may receive.

####Monitors or links?

- Links are bi-directional. If you link 2 processes and one of them craashes, the other side will crash too.
- Monitors are uni-directional: Just only the monitoring process will receive notifications about the monitored one.

- Briefly: Use links when you want linked crashes, and monitors when you just want to be informed or crashes, exits and so on.
 

