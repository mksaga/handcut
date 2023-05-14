defmodule HandCut.Projections.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset

  alias HandCut.Restaurant.Areas
  alias HandCut.Restaurant.Cuisines

  schema "restaurants" do
    field(:name, :string)
    field(:code, :string)
    field(:active, :boolean)
    field(:cash_only, :boolean)
    field(:activated_at, :utc_datetime)
    field(:address, :string)
    field(:phone, :string)
    field(:area, Ecto.Enum, values: Areas.all_areas())
    field(:cuisine, Ecto.Enum, values: Cuisines.all_cuisines())
    field(:url, :string)
    field(:instagram, :string)
    field(:google_maps, :string)

    timestamps()
  end

  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [
      :name,
      :code,
      :active,
      :cash_only,
      :activated_at,
      :address,
      :phone,
      :area,
      :cuisine,
      :url,
      :instagram,
      :google_maps
    ])
  end

  def activate_changeset(restaurant, %{activated_at: activated_at, active: true} = attrs) do
    restaurant
    |> cast(attrs, [
          :activated_at,
          :active
        ])
    |> put_change(:activated_at, activated_at)
    |> put_change(:active, true)
  end
end
