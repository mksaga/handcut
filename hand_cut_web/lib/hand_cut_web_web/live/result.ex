defmodule HandCutWebWeb.RestaurantResult do
  use HandCutWebWeb, :live_component

  def render(assigns) do
    ~H"""
    <a href={Routes.restaurant_path(@socket, :show, @result.code)}>
    <div class="card m-2">
        <div class="card-image">
            <figure class="image is-4by3">
                <img src="http://localhost:4000/images/placeholders/1280x960.png" alt="Placeholder image">
            </figure>
        </div>
        <div class="card-content">
            <div class="level is-mobile">
                <div class="level-left">
                    <p class="title is-4"><%= @result.name %></p>
                </div>
                <div class="level-right">
                    <p class="subtitle is-6"><%= @result.cuisine %></p>
                </div>
            </div>
        </div>
    </div>
    </a>
    """
  end
end
