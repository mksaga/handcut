defmodule HandCut.Projectors.CertificationProjector do

  alias HandCut.Projections.Certification
  alias HandCut.Events.{RestaurantCertificationCreated}

  use Commanded.Projections.Ecto,
    application: HandCut.Runtime.App,
    repo: HandCut.Projections.Repo,
    name: "certification"

  project(
    %RestaurantCertificationCreated{} = event,
    _metadata,
    fn multi ->
      Ecto.Multi.insert(
        multi,
        :certification,
        Certification.changeset(
          %Certification{},
          %{
            code: event.id,
            restaurant_id: event.restaurant_id,
            retailer_id: nil,
            supplier_id: nil,
            type: event.type,
            products: event.products,
            expiration: event.expiration,
            issuing_agency: event.issuing_agency,
          }
        )
      )
    end
  )
end
