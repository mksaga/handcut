defmodule HandCutWebWeb.ResultsLive do
  use HandCutWebWeb, :live_view
  alias HandCut.Projections.{Certification, Restaurant}
  alias HandCut.Restaurant.Areas
  alias HandCutWebWeb.RestaurantResult
  alias HandCutWebWeb.Components

  defmodule Result do
    defstruct restaurant: Restaurant, certification: Certification, label: :string
  end

  def mount(params, %{}, socket) do
    # Find restaurants in the area
    restaurant_matches = Restaurant.filter_search(params)

    certification_type = params["certification_type"] || "all"

    # Find unexpired certifications matching those restaurants
    certifications =
      restaurant_matches
      |> Enum.map(& &1.code)
      |> Certification.filter_search(certification_type)

    # Filter original restaurant list to those with valid certifications
    restaurant_results =
      restaurant_matches
      |> Enum.filter(fn match ->
        Enum.any?(certifications, fn cert -> cert.restaurant_id == match.code end)
      end)

    letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"

    results =
      Enum.with_index(restaurant_results, &{&2, &1})
      |> Enum.map(fn {index, result} ->
        %Result{
          restaurant: result,
          certification: Enum.find(certifications, &(&1.restaurant_id == result.code)),
          label: String.at(letters, index)
        }
      end)

      maps_key = Application.get_env(:hand_cut_web, :maps_api_key)

      title_prefix = case Components.humanize_certification_type(certification_type) do
        "All" -> "All Certified"
        x -> x
      end
      page_title = "#{title_prefix} Restaurants in #{Areas.humanize_area(params["area"])}"

    {:ok,
     socket
     |> assign(area: params["area"])
     |> assign(:maps_key, maps_key)
     |> assign(:page_title, page_title)
     |> assign(:results, results)}
  end

  def handle_event("get_restaurant_results", _value, socket) do
    results = Map.get(socket.assigns, :results)
    area = Map.get(socket.assigns, :area)
    maps_key = Map.get(socket.assigns, :maps_key)

    coordinates =
      Enum.map(results, fn result ->
        %{
          lat: result.restaurant.latitude,
          lng: result.restaurant.longitude,
          label: result.label
        }
      end)

    {:reply, %{results: coordinates, area: area, key: maps_key}, socket}
  end

  def render(assigns) do
    ~H"""
    <script>(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})
        ({key: "<%= @maps_key %>", v: "beta"});</script>
    <div class="container">
      <div class="level mb-1">
        <button class="button">
            <a phx-hook="BackHook" id="back" phx-update="ignore">
                <div class="icon-text">
                <span class="icon">
                    <ion-icon name="arrow-back-outline" class="ion-ionic arrow-back-outline"></ion-icon>
                </span>
                <span>Back</span>
                </div>
            </a>
        </button>
      <div class="level-item mt-2 mb-0">
        <h2 class="title is-4">
          <%= length(@results) %> result<%= if length(@results) != 1 do "s" end %> in <%= Areas.humanize_area(@area) %>
        </h2>
      </div>
        <div class="level-item">
          <p>if map is not appearing below, refresh!</p>
        </div>
      </div>
    </div>

    <%= if length(@results) > 0 do %>
      <div class="container is-max-desktop mt-2" id="map-container" phx-update="ignore">
        <figure class="image is-4by3" id="results-map" phx-hook="ResultsMap" phx-update="ignore" />
      </div>

      <div class="container is-max-desktop mt-2">
          <%= for result <- @results do %>
              <.live_component
                  module={RestaurantResult}
                  id={"result-#{result.restaurant.code}"}
                  result={result}}
              />
          <% end %>
      </div>
    <% end %>
    """
  end
end
