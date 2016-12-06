defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  test "store values by key" do
    {:ok, bucket} = KV.Bucket.start_link()
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end
end