defmodule HelloWorld.BucketTest do
  use ExUnit.Case, async: true

     setup do
        {:ok, bucket} = HelloWorld.Bucket.start_link
        {:ok, bucket: bucket}
      end

  test "stores values by key" do
    {:ok, bucket} = HelloWorld.Bucket.start_link
    assert HelloWorld.Bucket.get(bucket, "milk") == nil

    HelloWorld.Bucket.put(bucket, "milk", 3)
    assert HelloWorld.Bucket.get(bucket, "milk") == 3
  end
end
