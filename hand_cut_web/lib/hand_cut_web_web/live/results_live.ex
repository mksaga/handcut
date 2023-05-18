defmodule HandCutWebWeb.ResultsLive do
  use HandCutWebWeb, :live_view

  def mount(params, %{}, socket) do
    {:ok,
     socket
     |> assign(area: params["area"])
     |> assign(cuisines: params["cuisines"])}
  end

  def render(assigns) do
    ~H"""
    <div>Results</div>
    <div><%= @area %></div>
    <div><%= @cuisines %></div>
    """
  end
end
