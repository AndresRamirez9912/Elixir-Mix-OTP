defmodule KV.BucketTest do
  use ExUnit.Case, async: true #This async true means that the test can run in prallel with other process

  setup do #Define a setup callback (run before the test)
    {:ok,bucket}=KV.Bucket.start_link([]) #start my my bucket with a empty list
    %{bucket: bucket}
  end
  test("stores values by key", %{bucket: bucket}) do #create a test and get the bucket PID by the context
    assert KV.Bucket.get(bucket, "milk") == nil  #try to get the number of milks (the list is empty)

    KV.Bucket.put(bucket,"milk",3) # Add 3 elements with milk
    assert KV.Bucket.get(bucket, "milk") == 3  #get the number of milks (the list has elements)

    result= KV.Bucket.delete(bucket,"milk") #Delete the key milk and get the it value
    assert result == 3 # Compare the value after deleted
  end
end
