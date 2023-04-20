defmodule HandCut.Restaurant do
  use Ecto.Schema

  alias HandCut.Restaurant.Areas
  alias HandCut.Restaurant.Cuisines

  schema "restaurants" do
    field :name, :string
    field :code, :string
    field :active, :boolean
    field :activated_at, :utc_datetime
    field :address, :string
    field :phone, :string
    field :area, Ecto.Enum, values: Areas.all_areas()
    field :cuisine, Ecto.Enum, values: Cuisines.all_cuisines()
    field :url, :string
    field :instagram, :string
    field :google_maps, :string
  end
end
