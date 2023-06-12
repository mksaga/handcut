defmodule HandCut.Projections.Certification do
  use Ecto.Schema
  import Ecto.{Changeset, Query}
  alias HandCut.Projections.Certification

  product_types = [
    {"Chicken", :chicken},
    {"Beef", :beef},
    {"Veal", :veal},
    {"Lamb", :lamb},
    {"Goat", :goat}
  ]

  certification_types = [
    {"Certified Hand Slaughtered", :certified_hand_slaughtered},
    {"Certified Machine Slaughtered", :certified_machine_slaughtered},
    {"Owner Confirmed Machine Slaughtered", :owner_confirmed_machine_slaughtered},
    {"Owner Confirmed Hand Slaughtered", :owner_confirmed_hand_slaughtered},
  ]

  schema "certifications" do
    field(:restaurant_id, :string)
    field(:code, :string)
    field(:type, Ecto.Enum, values: Enum.map(certification_types, &elem(&1, 1)))
    field(:products, {:array, Ecto.Enum}, values: Enum.map(product_types, &elem(&1, 1)))
    field(:expiration, :date)
    field(:issuing_agency, :string)

    timestamps()
  end

  def changeset(certification, attrs) do
    certification
    |> cast(attrs, [
      :restaurant_id,
      :type,
      :code,
      :products,
      :expiration,
      :issuing_agency
    ])
  end

  def filter_search(restaurant_ids, certification_type) when length(restaurant_ids) > 0 do
    filter_restaurants(restaurant_ids)
    |> filter_certification_type(certification_type)
    |> select([c], map(c, [:code, :restaurant_id, :type, :products, :expiration, :issuing_agency]))
    |> HandCut.Projections.Repo.all()
  end

  def filter_search([], _certification_type) do
    []
  end

  def filter_restaurants(restaurant_ids) do
    "certifications"
    |> where([c], c.restaurant_id in ^restaurant_ids)
  end

  def filter_certification_type(query, certification_type) when certification_type != "all" do
    query
    |> filter_expiration
    |> where([c], c.type == ^certification_type)
  end

  def filter_certification_type(query, "all") do
    query
    |> filter_expiration
    |> select([c], map(c, [:code, :restaurant_id, :type, :products, :expiration, :issuing_agency]))
    |> HandCut.Projections.Repo.all()
  end

  def filter_expiration(query) do
    cutoff = Date.utc_today()
    query
    |> where([c], c.expiration >= ^cutoff)
  end


  def get_by_restaurant(restaurant_id) do
    HandCut.Projections.Repo.get_by(Certification, restaurant_id: restaurant_id)
  end
end
