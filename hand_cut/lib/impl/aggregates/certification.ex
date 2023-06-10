defmodule HandCut.Aggregates.Certification do
  @moduledoc """
  This module is an aggregate for certifications for restaurants, retailers, and suppliers.
  Tracks the expiration date
  """

  defstruct [
    :id,
    :restaurant_id,
    :type,
    :products,
    :expiration,
    :issuing_agency,
  ]

  alias HandCut.Aggregates.Certification
  alias HandCut.Commands.{CreateCertification}
  alias HandCut.Events.{RestaurantCertificationCreated}

  # Public API

  def execute(%Certification{id: nil}, %CreateCertification{restaurant_id: restaurant_id} = command) do
    event = %RestaurantCertificationCreated{
      id: command.id,
      restaurant_id: restaurant_id,
      type: command.type,
      products: command.products,
      expiration: command.expiration,
      issuing_agency: command.issuing_agency,
    }
    {:ok, event}
  end

  # State Mutators

  def apply(%Certification{}, %RestaurantCertificationCreated{} = event) do
    %Certification{
      id: event.id,
      restaurant_id: event.restaurant_id,
      type: event.type,
      products: event.products,
      expiration: event.expiration,
      issuing_agency: event.issuing_agency,
    }
  end

end
