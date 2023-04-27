defmodule HandCut.Aggregates.Restaurant do
  defstruct [
    :name,
    :id,
    :active,
    :activated_at,
    :address,
    :phone,
    :area,
    :cuisine,
    :url,
    :instagram,
    :google_maps,
  ]

  alias HandCut.Aggregates.Restaurant
  alias HandCut.Commands.{ActivateRestaurant, CreateRestaurant}
  alias HandCut.Events.{RestaurantCreated, RestaurantActivated}

  # Public API

  def execute(%Restaurant{id: nil}, %CreateRestaurant{} = command) do
    %CreateRestaurant{
      name: name,
      id: id,
      address: address,
      cash_only: cash_only,
      area: area,
      cuisine: cuisine,
      url: url,
      instagram: instagram,
      google_maps: google_maps
    } = command

    event = %RestaurantCreated{
      name: name,
      id: id,
      address: address,
      cash_only: cash_only,
      area: area,
      cuisine: cuisine,
      url: url,
      instagram: instagram,
      google_maps: google_maps,
    }

    {:ok, event}
  end

  # If `id` is already assigned, don't re-create
  def execute(%Restaurant{}, %CreateRestaurant{}),
    do: {:error, :already_created}

  def execute(%Restaurant{id: id, active: false}, %ActivateRestaurant{id: id}) do
    event = %RestaurantActivated{
      id: id,
      activated_at: DateTime.now("Etc/UTC"),
    }

    {:ok, event}
  end


  def execute(%Restaurant{id: _id, active: true}, %ActivateRestaurant{}) do
    {:error, :restaurant_already_active}
  end

    # State Mutators

  def apply(%Restaurant{}, %RestaurantCreated{} = event) do
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

    %Restaurant{
      name: name,
      id: id,
      active: false,
      activated_at: nil,
      address: address,
      phone: phone,
      area: area,
      cuisine: cuisine,
      url: url,
      instagram: instagram
    }
  end
end
