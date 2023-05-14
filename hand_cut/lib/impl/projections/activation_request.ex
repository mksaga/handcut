defmodule HandCut.Projections.ActivationRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "activation_requests" do
    field(:restaurant_code, :string)
    field(:approved, :boolean)

    timestamps()
  end

  def changeset(activation_req, attrs) do
    activation_req
    |> cast(attrs, [
          :restaurant_code,
          :approved
        ])
  end

  def approve_changeset(activation_req, %{approved: true} = attrs) do
    activation_req
    |> cast(attrs, [:approved])
    |> put_change(:approved, true)
  end
end
