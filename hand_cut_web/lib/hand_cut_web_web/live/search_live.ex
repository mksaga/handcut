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
    Areas.all_areas()
  end

  def mount(_params, %{}, socket) do
    {:ok,
     socket
     |> assign(form: to_form(%{"area" => :ny_brooklyn, "certification_type" => :certified_hand_slaughtered}))
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
    <div class="level">
        <div class="level-item">
            <h1 class="title">Welcome to HandCut!</h1>
        </div>
        <div class="level-item">
            <h2 class="subtitle">
                Find certified hand- or machine-slaughtered restaurants below.
            </h2>
        </div>

        <.form for={@form} let={f} phx-change="update" phx-submit="search">
            <div class="level-item">
                <.live_component module={AreaSelect} id="area-select" options={areas()} form={f}/>
            </div>

            <div class="level-item">
                <.live_component module={CertificationSelect} id="area-select" options={certification_types()} form={f}/>
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
