defmodule HandCut.Runtime.Application do
  use Application

  def start(_type, _args) do
    HandCut.Runtime.Server.start_link()
  end
end
