defmodule HandCut.Projectors.ActivationRequestProjector do

  alias HandCut.Projections.ActivationRequest
  alias HandCut.Events.{ActivationRequestApproved, ActivationRequestCreated}

  use Commanded.Projections.Ecto,
    application: HandCut.Runtime.App,
    repo: HandCut.Projections.Repo,
    name: "activation_request"

  project(
    %ActivationRequestCreated{} = event,
    _metadata,
    fn multi ->
      Ecto.Multi.insert(
        multi,
        :activation_request,
        ActivationRequest.changeset(
          %ActivationRequest{},
          %{
            restaurant_code: event.restaurant_code,
            approved: false
          }
        )
      )
    end
  )

  project(
    %ActivationRequestApproved{
      restaurant_code: code
    },
    _metadata,
    fn multi ->
      Ecto.Multi.update(
        multi,
        :activation_request,
        ActivationRequest.approve_changeset(
          HandCut.Projections.Repo.get_by(ActivationRequest, restaurant_code: code),
          %{
            restaurant_code: code,
            approved: false
          }
        )
      )
    end
  )
end
