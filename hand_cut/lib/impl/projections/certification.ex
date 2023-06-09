defmodule HandCut.Projections.Certification do
  use Ecto.Schema
  import Ecto.Changeset

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
    {"Owner Confirmed Hand Slaughtered", :owner_confirmed_hand_slaughtered}
  ]

  schema "certifications" do
    field(:restaurant_id, :string)
    field(:retailer_id, :string)
    field(:supplier_id, :string)
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
      :retailer_id,
      :supplier_id,
      :type,
      :code,
      :products,
      :expiration,
      :issuing_agency
    ])
  end
end
