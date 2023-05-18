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
     socket
     |> assign(form: to_form(%{"area" => nil, "cuisines" => []}))}
  end

  def handle_event("search", params, socket) do
    # `params` has what we need!!
    {:noreply, socket}
  end

  def handle_event("update", %{"area" => new_area, "cuisines" => new_cuisines} = revised_form, socket) do
    {:noreply, assign(socket, form: %{revised_form | "area" => new_area, "cuisines" => new_cuisines})}
end

  def render(assigns) do
    ~H"""
    <div class="level">
        <div class="level-item">
            <h1 class="title">Welcome to HandCut!</h1>
        </div>
        <div class="level-item">
            <h2 class="subtitle">Let us know where you're looking and what you're craving.</h2>
        </div>

        <.form for={@form} let={f} phx-change="update" phx-submit="search">
            <div class="level-item">
                <.live_component module={AreaSelect} id="area-select" options={areas()} form={f}/>
            </div>
            <div class="level-item">
                <.live_component module={CuisineSelect} id="cuisine-select" label="Cuisine(s)" options={cuisines()} form={f}/>
            </div>

            <div class="level-item">
                <div class="field">
                    <div class="control">
                        <%= submit "Search", class: "button is-link" %>
                    </div>
                </div>
            </div>
        </.form>

        </div>
    """
  end
end