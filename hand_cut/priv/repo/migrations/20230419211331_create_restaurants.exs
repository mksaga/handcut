defmodule HandCut.Repo.Migrations.CreateRestaurants do
  use Ecto.Migration

  def change do
    create table(:restaurants) do
      add :name, :string
      add :code, :string
      add :active, :boolean
      add :cash_only, :boolean
      add :activated_at, :utc_datetime
      add :address, :string
      add :phone, :string
      # Ecto Enum in the schema
      add :area, :string
      # Ecto Enum in the schema
      add :cuisine, :string
      add :url, :string
      add :instagram, :string
      add :google_maps, :string
    end
  end
end
