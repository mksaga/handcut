defmodule HandCutWebWeb.PageController do
  use HandCutWebWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
