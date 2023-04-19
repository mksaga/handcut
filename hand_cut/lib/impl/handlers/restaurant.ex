defmodule RestaurantHandler do
  @me __MODULE__

  @behaviour Commanded.Commands.Handler

  alias HandCut.Aggregates.Restaurant
  alias HandCut.Events.{RestaurantCreated}

  use Commanded.Event.Handler,
    application: HandCut.Runtime.App,
    name: @me

    def init do
      with {:ok, _pid} <- Agent.start_link(fn -> nil end, name: @me) do
        :ok
      end
    end

    def handle(%RestaurantCreated{} = event, _metadata) do
      %RestaurantCreated{
        name: name,
        id: id,
        address: address,
        phone: phone,
        area: area,
        cuisine: cuisine,
        url: url,
        instagram: instagram
      } = event

      new_restaurant = %Restaurant{
        name: name,
        id: id,
        address: address,
        phone: phone,
        area: area,
        cuisine: cuisine,
        url: url,
        instagram: instagram
      }

      Agent.get(@me, fn state -> state end)
      |> update_if_new(new_restaurant)
    end

    def update_if_new(nil, new_restaurant) do
      Agent.update(@me, fn _ -> new_restaurant end)
    end

    def update_if_new(_, _new_restaurant) do
      {:error, :restaurant_exists}
    end

  end
