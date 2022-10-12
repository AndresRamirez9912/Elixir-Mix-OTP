defmodule MyModule.Supervisor do
  use Supervisor #I want to import the supervisor behaviour

  def init(state) do
    IO.puts("The supervisor is initing")
    {:ok, state}
  end

  def start_link() do
    childs = [MyModule.Child1, MyModule.Child2]  # Here I declared the array of process that I want to supervice
    Supervisor.start_link(childs, strategy: :one_for_one) # Init the songs
  end

end
