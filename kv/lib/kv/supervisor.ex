defmodule KV.Supervisor do
  use Supervisor #Import the supervisor module

  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @impl true
  def init(:ok) do
    children = [
      KV.Registry
    ]

    Supervisor.init(children, strategy: :one_for_one)  #Start the child process
  end
end
