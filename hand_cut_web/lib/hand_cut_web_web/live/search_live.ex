defmodule HandCutWebWeb.SearchLive do
  use HandCutWebWeb, :live_view

  alias HandCutWebWeb.SearchUI
  alias HandCutWebWeb.SearchForm
  alias HandCutWebWeb.{AreaSelect, CuisineSelect}
  alias HandCut.Restaurant.{Cuisines, Areas}

  def cuisines() do
    Cuisines.all_cuisines()
  end

  def areas() do
    Areas.all_areas()
  end

  def mount(_params, %{}, socket) do
    {:ok,
     assign(socket, :areas, [])
     |> assign(:cuisines, [])}
  end

  def render(assigns) do
    ~H"""
    <div class="level">
        <div class="level-item">
            <h1 class="title">Welcome</h1>
        </div>
        <div class="level-item">
            <h2 class="subtitle">Let us know where you're looking and what you're craving.</h2>
        </div>



        <div class="level-item">
            <.live_component module={AreaSelect} id="area-select" options={areas()} />
        </div>
        <div class="level-item">
            <.live_component module={CuisineSelect} id="cuisine-select" options={cuisines()} label="Cuisine(s)" />
        </div>
        <div class="level-item">
            <SearchUI.submit />
        </div>
    </div>
    """
  end
end
