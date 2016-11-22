defmodule HelloWorld.RegistryTest do
  use ExUnit.Case, async: true

  setup context do
    {:ok, registry} = HelloWorld.Registry.start_link(context.test)
    {:ok, registry: registry}
  end


  test "spawns buckets", %{registry: registry} do
    assert HelloWorld.Registry.lookup(registry, "shopping") == :error

    HelloWorld.Registry.create(registry, "shopping")
    assert {:ok, bucket} = HelloWorld.Registry.lookup(registry, "shopping")

    HelloWorld.Bucket.put(bucket, "milk", 1)
    assert HelloWorld.Bucket.get(bucket, "milk") == 1
  end

  test "removes buckets on exit", %{registry: registry} do
    HelloWorld.Registry.create(registry, "shopping")
    {:ok, bucket} = HelloWorld.Registry.lookup(registry, "shopping")
    Agent.stop(bucket)
    assert HelloWorld.Registry.lookup(registry, "shopping") == :error
  end
end