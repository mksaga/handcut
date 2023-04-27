defmodule HandCut.Restaurant do
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
end
