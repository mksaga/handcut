defmodule HandCutWebWeb.ResultsLive do
  use HandCutWebWeb, :live_view
  alias HandCut.Projections.Restaurant
  alias HandCutWebWeb.RestaurantResult

  def mount(params, %{}, socket) do
    results = Restaurant.filter_search(params)

    {:ok,
     socket
     |> assign(area: params["area"])
     |> assign(cuisines: params["cuisines"])
     |> assign(results: results)}
  end

  def render(assigns) do
    ~H"""
    <div class="level">
        <div class="level-item">
            <h1 class="title">Results</h1>
        </div>
        <div class="level-item">
            <h2 class="subtitle"><%= length(@results) %> <%= @cuisines %> in <%= @area %></h2>
        </div>
    </div>
    <div>
        <%= for result <- @results do %>
            <.live_component module={RestaurantResult} id={"result-#{result.code}"} result={result}} />
        <% end %>
    </div>
    """
  end
end
