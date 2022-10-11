defmodule KV.Bucket do
  use Agent #import the Agent module

  @doc """
    This function start the bucket
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)  #start the agent with a empty map
  end

  @doc """
  Get the value from the key in the bucket
  """
  def get(bucket,key) do
    Agent.get(bucket,&Map.get(&1,key))
  end

  @doc """
    Put the 'value' from a given key
  """
  def put(bucket,key,value) do
    Agent.update(bucket, &Map.put(&1,key,value))
  end

  @doc """
  Delete a key and get the current value
  """
  def delete(bucket,key) do
    Agent.get_and_update(bucket, &Map.pop(&1,key)) #Delete in the map the key and return the value
  end

end
