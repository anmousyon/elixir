defmodule Reddixir do
  use Application

  def start(_type, _args) do
    Reddixir.Supervisor.start_link
  end

end