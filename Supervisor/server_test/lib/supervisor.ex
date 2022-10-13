defmodule MyModule.Supervisor do
  use Supervisor #I want to import the supervisor behaviour

  def init(state) do
    IO.puts("The supervisor is initing")
    childs = [MyModule.Child1, MyModule.Child2]  # Here I declared the array of process that I want to supervice
    Supervisor.init(childs,strategy: :one_for_one)
    {:ok, state}
  end

  def start_link(_args) do
    Supervisor.start_link(__MODULE__, :ok,name: __MODULE__) # Init the songs

  end

end
