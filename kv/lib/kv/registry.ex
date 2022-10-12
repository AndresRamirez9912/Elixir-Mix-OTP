defmodule KV.Registry do
  use GenServer

  @impl true #This means that the following function it's a callback
  def init(:ok) do #Create an empty map
    {:ok, %{}}
  end

  @impl true
  def handle_call({:lookup, name}, _from, names) do #Synchronous and server must response inmediatly
    {:reply, Map.fetch(names, name), names}
  end

  @impl true
  def handle_cast({:create, name}, names) do #Asynchronous because the server won't response
    if Map.has_key?(names, name) do
      {:noreply, names}
    else
      {:ok, bucket} = KV.Bucket.start_link([])
      {:noreply, Map.put(names, name, bucket)}
    end
  end

end
