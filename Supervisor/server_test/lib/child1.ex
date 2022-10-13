defmodule MyModule.Child1 do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok) #Start connection and the info is just :ok
  end

  def init(:ok) do
    IO.puts("Child 1 Init")
    {:ok, 0} #Return the initial state
  end

  def handle_call(:ok, _from, state) do
    IO.puts("Request received by Child 1")
    {:reply, "Hello from Child 1", state+1}
  end

end
