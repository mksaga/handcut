defmodule HandCut.Aggregates.ActivationRequest do
  defstruct [
    :restaurant_code,
    :approved
  ]

  alias HandCut.Aggregates.ActivationRequest
  alias HandCut.Commands.{CreateActivationRequest, ApproveActivationRequest}
  alias HandCut.Events.{ActivationRequestApproved, ActivationRequestCreated, RestaurantCreated}

  # Public API

  def execute(
        %ActivationRequest{restaurant_code: nil},
        %CreateActivationRequest{restaurant_code: code} = command
      ) do
    event = %ActivationRequestCreated{
      restaurant_code: code
    }

    {:ok, event}
  end

  def execute(
        %ActivationRequest{restaurant_code: code},
        %CreateActivationRequest{restaurant_code: code} = command
      ) do
    {:ok, []}
  end

  # TODO: figure out what is going on here?
  def execute(
        nil,
        %CreateActivationRequest{restaurant_code: code} = command
      ) do
    event = %ActivationRequestCreated{
      restaurant_code: code
    }

    {:ok, event}
  end

  def execute(%ActivationRequest{restaurant_code: code}, %ApproveActivationRequest{
        restaurant_code: code
      }) do
    {:ok, %ActivationRequestApproved{restaurant_code: code}}
  end

  # State Mutators

  def apply(%ActivationRequest{}, %ActivationRequestCreated{restaurant_code: code} = event) do
    %ActivationRequest{
      restaurant_code: code,
      approved: false
    }
  end

  # TODO: figure out what is going on here?
  def apply(nil, %ActivationRequestCreated{restaurant_code: code} = event) do
    %ActivationRequest{
      restaurant_code: code,
      approved: false
    }
  end

  def apply(%ActivationRequest{restaurant_code: nil}, %RestaurantCreated{id: code}) do
    # Don't do anything, let process manager handle
    # %ActivationRequest{restaurant_code: code, approved: false}
  end

  def apply(
        %ActivationRequest{restaurant_code: code} = activation_req,
        %ActivationRequestApproved{restaurant_code: code} = event
      ) do
    %{activation_req | approved: true}
  end
end
