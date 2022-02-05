defmodule Entrypoint do
  use Application

  def start(_type, _args) do
    CallAnApi.run()
    Supervisor.start_link [], strategy: :one_for_one
  end
end
