defmodule HandCut.Aggregates.Restaurant do
  defstruct [
    :name,
    :id,
    :active,
    :activated_at,
    :address,
    :cash_only,
    :phone,
    :area,
    :cuisine,
    :url,
    :latitude,
    :longitude,
    :instagram,
    :google_maps,
  ]

  alias HandCut.Aggregates.Restaurant
  alias HandCut.Commands.{ActivateRestaurant, CreateRestaurant}
  alias HandCut.Events.{RestaurantCreated, RestaurantActivated}
  alias HandCut.Events.{ActivationRequestCreated}

  # Public API

  def execute(%Restaurant{id: nil}, %CreateRestaurant{} = command) do
    event = %RestaurantCreated{
      name: command.name,
      id: command.id,
      address: command.address,
      phone: command.phone,
      cash_only: command.cash_only,
      area: command.area,
      cuisine: command.cuisine,
      url: command.url,
      latitude: command.latitude,
      longitude: command.longitude,
      instagram: command.instagram,
      google_maps: command.google_maps,
    }

    {:ok, event}
  end

  # If `id` is already assigned, don't re-create
  def execute(%Restaurant{}, %CreateRestaurant{}),
    do: {:error, :already_created}

  def execute(%Restaurant{id: id, active: false}, %ActivateRestaurant{id: id}) do
    event = %RestaurantActivated{
      id: id,
      activated_at: DateTime.utc_now(),
    }

    {:ok, event}
  end


  def execute(%Restaurant{id: _id, active: true}, %ActivateRestaurant{}) do
    {:error, :restaurant_already_active}
  end

    # State Mutators

  def apply(%Restaurant{}, %RestaurantCreated{} = event) do
    %Restaurant{
      name: event.name,
      id: event.id,
      active: false,
      activated_at: nil,
      address: event.address,
      phone: event.phone,
      cash_only: event.cash_only,
      area: event.area,
      cuisine: event.cuisine,
      url: event.url,
      latitude: event.latitude,
      longitude: event.longitude,
      instagram: event.instagram,
      google_maps: event.google_maps,
    }
  end

  def apply(%Restaurant{id: code} = restaurant, %RestaurantActivated{id: code} = _event) do
    %{restaurant | active: true}
  end

  # Nothing to do here! Process manager will handle
  def apply(%Restaurant{id: code} = restaurant, %ActivationRequestApproved{restaurant_code: code}) do
    restaurant
  end

  # Nothing to do here!
  def apply(%Restaurant{id: code} = restaurant, %ActivationRequestCreated{restaurant_code: code}) do
    restaurant
  end
end
