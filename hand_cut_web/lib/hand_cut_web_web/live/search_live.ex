defmodule HandCutWebWeb.SearchLive do
  use HandCutWebWeb, :live_view

  alias HandCutWebWeb.{AreaSelect, CertificationSelect}
  alias HandCut.Restaurant.{Cuisines, Areas}

  def cuisines() do
    Cuisines.all_cuisines()
  end

  def certification_types() do
   # TODO pull this from projection
   # types = Enum.map(HandCut.Projections.Certification.certification_types, &(elem(&1, 1)))
   # [{"All", :all} | types]
   [
     {"All", :all},
     {"Hand Slaughtered", :certified_hand_slaughtered},
     {"Machine Slaughtered", :certified_machine_slaughtered},
   ]
  end

  def areas() do
    excluded_areas = [:nj_newark, "nj_newark"]
    Areas.all_areas()
    |> Enum.filter(fn x -> not Enum.member?(excluded_areas, x) end)
    |> Enum.sort()
  end

  def mount(_params, %{}, socket) do
    {:ok,
     socket
     |> assign(form: to_form(%{"area" => :nj_paterson, "certification_type" => :certified_hand_slaughtered}))
     |> assign(:page_title, "Search")}
  end

  def handle_event("search", params, socket) do
    # URI.encode_query does not support list arguments so using Plug.Conn instead
    query = Plug.Conn.Query.encode(params)
    {:noreply, push_navigate(socket, to: "/results?#{query}")}
  end

  def handle_event("update", %{"area" => new_area} = form, socket) do
    {:noreply, assign(socket, form: %{form | "area" => new_area})}
  end

  def handle_event("update", %{"certification_type" => certification_type} = form, socket) do
    {:noreply, assign(socket, form: %{form | "certification_type" => certification_type})}
  end

  #   def handle_event("update", %{"area" => new_area, "cuisines" => new_cuisines} = revised_form, socket) do
  #     {:noreply, assign(socket, form: %{revised_form | "area" => new_area, "cuisines" => new_cuisines})}
  # end

  # 18 May 2023: thought about it and since we don't have many zabiha options just yet,
  # will remove cuisine selection from search and show all restaurants in area X
  # <.live_component module={CuisineSelect} id="cuisine-select" options={cuisines()} form={f}/>
  def render(assigns) do
    ~H"""
    <div class="container is-flex is-flex-direction-column is-align-items-center">
        <div>
            <h1 class="title">Welcome to HandCut!</h1>
        </div>
        <div>
            <h2 class="subtitle">
                Find certified hand- or machine-slaughtered restaurants below.
            </h2>
        </div>

        <.form for={@form} :let={f} phx-change="update" phx-submit="search">
          <.live_component module={AreaSelect} id="area-select" options={areas()} form={f}/>
          <.live_component module={CertificationSelect} id="area-select" options={certification_types()} form={f}/>
          <div class="field">
            <%= submit "Search", class: "button is-link mx-6" %>
          </div>
        </.form>

        </div>
    """
  end
end
