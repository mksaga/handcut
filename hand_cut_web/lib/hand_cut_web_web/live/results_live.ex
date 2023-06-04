defmodule HandCutWebWeb.ResultsLive do
  use HandCutWebWeb, :live_view
  alias HandCut.Projections.Restaurant
  alias HandCutWebWeb.RestaurantResult

  def mount(params, %{}, socket) do
    results = Restaurant.filter_search(params)
    maps_key = "AIzaSyAZA0YnVq0_j6i-W8CdTURho9JtQhDExSU"

    coords = [
      %{lat: 40.76125737705498, lng: -73.92321132959674, label: "A"},
      %{lat: 40.72365196768409, lng: -73.86882868726936, label: "B"}
    ]

    {:ok,
     socket
     |> assign(area: params["area"])
     |> assign(cuisines: params["cuisines"])
     |> assign(:maps_key, maps_key)
     |> assign(results: results)
     |> assign(coords: coords)}
  end

  def handle_event("get_restaurant_results", _value, socket) do
    {:reply, %{results: Map.get(socket.assigns, :coords)}, socket}
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

    <figure class="image is-4by3" id="results-map" phx-hook="ResultsMap" />

    <div>
        <%= for result <- @results do %>
            <.live_component module={RestaurantResult} id={"result-#{result.code}"} result={result}} />
        <% end %>
    </div>
    <script>(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})
    ({key: "<%= @maps_key %>", v: "quarterly"});</script>
    """
  end
end
