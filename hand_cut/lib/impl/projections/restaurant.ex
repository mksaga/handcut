defmodule HandCut.Projections.Restaurant do
  use Ecto.Schema
  import Ecto.{Changeset, Query}

  alias HandCut.Projections.Restaurant
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
    field(:area, Ecto.Enum, values: Areas.all_area_atoms())
    field(:cuisine, Ecto.Enum, values: Cuisines.all_cuisine_atoms())
    field(:url, :string)
    field(:latitude, :float)
    field(:longitude, :float)
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
      :latitude,
      :longitude,
      :google_maps
    ])
  end

  def update_changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [
      :name,
      :cash_only,
      :address,
      :phone,
      :area,
      :cuisine,
      :url,
      :instagram,
      :latitude,
      :longitude,
    ])
    |> put_change(:name, attrs.name || restaurant.name)
    |> put_change(:cash_only, attrs.cash_only || restaurant.cash_only)
    |> put_change(:address, attrs.address || restaurant.address)
    |> put_change(:phone, attrs.phone || restaurant.phone)
    |> put_change(:area, attrs.area || restaurant.area)
    |> put_change(:cuisine, attrs.cuisine || restaurant.cuisine)
    |> put_change(:url, attrs.url || restaurant.url)
    |> put_change(:instagram, attrs.instagram || restaurant.instagram)
    |> put_change(:latitude, attrs.latitude || restaurant.latitude)
    |> put_change(:longitude, attrs.longitude || restaurant.longitude)
  end

  def location_changeset(
        restaurant,
        %{latitude: latitude, longitude: longitude, address: address} = attrs
      ) do
    restaurant
    |> cast(attrs, [
      :latitude,
      :longitude,
      :address
    ])
    |> put_change(:latitude, latitude)
    |> put_change(:longitude, longitude)
    |> put_change(:address, address)
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

  def get_by_code(code) do
    HandCut.Projections.Repo.get_by(Restaurant, code: code)
  end

  def get_multiple_by_code(codes) do
     "restaurants"
      # TODO: filter on active also
      # |> where([r], r.active == true)
      |> where([r], r.code in ^codes)
      |> select(
        [r],
        map(r, [
          :name,
          :code,
          :address,
          :phone,
          :area,
          :cuisine,
          :url,
          :instagram,
          :latitude,
          :longitude
        ]))
      |> HandCut.Projections.Repo.all()
  end

  def filter_search(params) do
    results =
      "restaurants"
      # TODO: filter on active also
      # |> where([r], r.active == true)
      |> filter_area(params["area"])
      |> filter_cuisines(params["cuisines"])
      |> select(
        [r],
        map(r, [
          :name,
          :code,
          :address,
          :phone,
          :area,
          :cuisine,
          :url,
          :instagram,
          :latitude,
          :longitude
        ])
      )
      |> order_by([r], r.name)
      |> HandCut.Projections.Repo.all()

    results
  end

  def filter_area(query, area) do
    query
    |> where([r], r.area == ^area)
  end

  # Don't restrict results if no cuisines are provided
  def filter_cuisines(query, nil) do
    query
  end

  def filter_cuisines(query, cuisines) do
    query
    |> where([r], r.cuisine in ^cuisines)
  end
end
