defmodule HandCutWebWeb.RestaurantLive do
  use HandCutWebWeb, :live_view
  alias HandCut.Projections.Restaurant
  alias HandCutWebWeb.RestaurantResult

  def mount(params, %{}, socket) do
    restaurant = Restaurant.get_code("restaurant_" <> params["code"])
    certification = %{type: "monitoring_agency", agency: "HMS", expires: ~D[2023-12-31]}
    maps_key = "AIzaSyAZA0YnVq0_j6i-W8CdTURho9JtQhDExSU"

    IO.inspect "OKAYYYYYYY okAY DAWG"
    push_event(socket, "map-init", %{
      lat: -25.344,
      lng: 131.031
    })

    google_maps_url = "/search"
    apple_maps_url = "/search"

    {:ok,
     socket
     |> assign(:restaurant, restaurant)
     |> assign(:certification, certification)
     |> assign(:maps_key, maps_key)
     |> assign(:google_maps_url, google_maps_url)
     |> assign(:apple_maps_url, apple_maps_url)
    }
  end


  def handle_event("ping", params, socket) do
    # URI.encode_query does not support list arguments so using Plug.Conn instead
    IO.puts "hey there"
    push_event(socket, "map-init", %{
      lat: -25.344,
      lng: 131.031
    })
    IO.puts "map? daan."
    {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="level">
        <button class="button">
            <a href={Routes.results_path(@socket, :index, area: @restaurant.area)}>
                <div class="icon-text">
                <span class="icon">
                    <ion-icon name="arrow-back-outline" class="ion-ionic arrow-back-outline"></ion-icon>
                </span>
                <span>Back</span>
                </div>
            </a>
        </button>
    </div>
    <div>
    <h1 class="title" phx-click="ping"><%= @restaurant.name %></h1>
    <figure class="image is-16by9" phx-hook="RestaurantMap" id="map">
              <img src="http://localhost:4000/images/placeholders/640x360.png" />
    </figure>
    <div class="level is-mobile pt-2">
        <div class="level-left">
            <div class="level">
                <div class="level-item">
                    <p>
                      <%= @restaurant.address %>
                    </p>
                </div>
                <div class="level-item">
                    <!-- TODO Fix telephone link -->
                    <a href={"tel+" <> @restaurant.phone}><p><%= @restaurant.phone %></p></a>
                </div>
            </div>
        </div>
        <div class="level-right">
            <div class="level-item">
                <span class="tag is-primary is-light"><%= @restaurant.cuisine %></span>
            </div>
        </div>
    </div>
    <div class="level is-mobile">
        <p><a href={@google_maps_url}>google maps</a> | <a href={@apple_maps_url}>apple maps</a></p>
    </div>
    <div class="level is-mobile pt-2">
        <div class="level-left">
            <div class="level">
                    <div class="level-item">
                        <p>Certification: <%= @certification.type %>
                            <!-- TODO: link to an explain page -->
                            <a href="/search">
                            <ion-icon name="information-circle-outline"></ion-icon>
                            </a>
                        </p>
                    </div>
                    <%= if not is_nil(@certification.agency) do %>
                        <div class="level-item">
                            <p>
                                Certified by <%=  @certification.agency %>
                                (exp. <%= @certification.expires %>)
                            </p>
                        </div>
                    <% end %>
            </div>
        </div>
    </div>
    </div>
    <script>console.log("hi")</script>
    <script>(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})
    ({key: "<%= @maps_key %>", v: "quarterly"});</script>
    <script>console.log("hey")</script>
    """
  end
end
