defmodule HandCutWebWeb.RestaurantResult do
  use HandCutWebWeb, :live_component

  alias HandCutWebWeb.Components

  defp humanize_certification_type("certified_hand_slaughtered") do
    "Certified Hand Slaughtered"
  end

  def render(assigns) do
    ~H"""
    <a href={Routes.restaurant_path(@socket, :show, String.split(@result.restaurant.code, "_") |> Enum.at(1))}>
    <div class="card mb-1">
        <div class="card-content p-4">
            <div class="level is-mobile">
                <div class="level-left">
                    <div>
                      <p class="title is-5 mb-0">
                        <span class="tag is-danger"><%= @result.label %></span>
                        <%= @result.restaurant.name %>
                      </p>
                        <%= if @result.certification != nil do %>
                          <Components.certification_label certification={@result.certification} />
                        <% end %>
                    </div>
                </div>
                <div class="level-right">
                  <div class="level-item">
                    <Components.cuisine_label cuisine={@result.restaurant.cuisine} />
                    </div>
                </div>
            </div>
        </div>
    </div>
    </a>
    """
  end
end
