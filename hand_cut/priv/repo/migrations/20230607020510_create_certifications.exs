defmodule HandCut.Projections.Repo.Migrations.CreateCertifications do
  use Ecto.Migration

  def change do
    create table(:certifications) do
      add :restaurant_id, :string
      add :code, :string
      # Ecto Enum in the schema
      add :type, :string
      # Ecto Enum in the schema
      add :products, {:array, :string}
      add :expiration, :date
      add :issuing_agency, :string

      timestamps()
    end

  end
end
