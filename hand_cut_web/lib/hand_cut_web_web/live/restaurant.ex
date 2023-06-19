defmodule HandCutWebWeb.RestaurantLive do
  use HandCutWebWeb, :live_view
  alias HandCut.Projections.{Certification, Restaurant}
  alias HandCutWebWeb.Components

  def mount(params, %{}, socket) do
    restaurant = Restaurant.get_by_code("restaurant_" <> params["code"])
    certification = Certification.get_by_restaurant(restaurant.code)

    lat_long_string = "#{restaurant.latitude},#{restaurant.longitude}"
    query_string = "#{restaurant.name},#{restaurant.address}"

    maps_key = Application.get_env(:hand_cut_web, :maps_api_key)

    # TODO use Google place ID
    google_maps_url = "https://www.google.com/maps/search/?api=1&query=#{URI.encode(query_string)}"
    apple_maps_url = "https://maps.apple.com/?q=#{URI.encode(restaurant.name)}&sll=#{lat_long_string}"

    {:ok,
     socket
     |> assign(:restaurant, restaurant)
     |> assign(:certification, certification)
     |> assign(:maps_key, maps_key)
     |> assign(:page_title, restaurant.name)
     |> assign(:google_maps_url, google_maps_url)
     |> assign(:apple_maps_url, apple_maps_url)
    }
  end

  def render(assigns) do
    ~H"""
    <div class="level">
        <button class="button">
            <a phx-hook="BackHook" id="back">
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
    <figure class="image is-16by9" phx-hook="RestaurantMap" id="map" data-lat={@restaurant.latitude} data-long={@restaurant.longitude} data-name={@restaurant.name} />
    <div class="level is-mobile pt-2 mb-1">
        <div class="level-left">
            <div>
                <div class="is-flex is-flex-direction-row is-align-items-center mb-1">
                    <p>
                      <span id="address" data-value={@restaurant.address}><%= @restaurant.address %></span>
                    </p>
                    <button class="button is-small is-rounded ml-2" phx-hook="Copy" id="copy-address" data-to="#address"><ion-icon name="copy-outline" class="ion-ionic"></ion-icon></button>
                    <span class="tag is-info is-light ml-2 is-hidden" id="copied-text">Copied!</span>
                </div>
                <div>
                    <a href={@google_maps_url}>
                        <button class="button is-small is-link">Google Maps</button>
                    </a>
                    <a href={@apple_maps_url}>
                        <button class="button is-small is-link">Apple Maps</button>
                    </a>
                </div>
            </div>
        </div>
        <div class="level-right">
            <div class="level-item">
                    <Components.atom_cuisine_label cuisine={@restaurant.cuisine} />
            </div>
        </div>
    </div>
    <a href={"tel:" <> @restaurant.phone}><p><%= @restaurant.phone %></p></a>
    <div class="level is-mobile pt-2">
        <div class="level-left">
            <div class="level">
                    <%= if not is_nil(@certification) do %>
                    <div>
                        <Components.certification_label certification={@certification} />
                            <!-- TODO: link to an explain page -->
                            <a href="/search">
                            <ion-icon name="information-circle-outline"></ion-icon>
                            </a>
                            <p>
                                Certified by <%=  @certification.issuing_agency %>
                                (exp. <%= @certification.expiration %>)
                            </p>
                    </div>
                    <% end %>
            </div>
        </div>
    </div>
    </div>
    <script>(g=>{var h,a,k,p="The Google Maps JavaScript API",c="google",l="importLibrary",q="__ib__",m=document,b=window;b=b[c]||(b[c]={});var d=b.maps||(b.maps={}),r=new Set,e=new URLSearchParams,u=()=>h||(h=new Promise(async(f,n)=>{await (a=m.createElement("script"));e.set("libraries",[...r]+"");for(k in g)e.set(k.replace(/[A-Z]/g,t=>"_"+t[0].toLowerCase()),g[k]);e.set("callback",c+".maps."+q);a.src=`https://maps.${c}apis.com/maps/api/js?`+e;d[q]=f;a.onerror=()=>h=n(Error(p+" could not load."));a.nonce=m.querySelector("script[nonce]")?.nonce||"";m.head.append(a)}));d[l]?console.warn(p+" only loads once. Ignoring:",g):d[l]=(f,...n)=>r.add(f)&&u().then(()=>d[l](f,...n))})
    ({key: "<%= @maps_key %>", v: "quarterly"});</script>
    """
  end
end
