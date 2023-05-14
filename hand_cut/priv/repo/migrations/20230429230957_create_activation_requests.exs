defmodule HandCut.Projections.Repo.Migrations.CreateActivationRequests do
  use Ecto.Migration

  def change do
    create table(:activation_requests) do
      add :restaurant_code, :string
      add :approved, :boolean

      timestamps()
    end

  end
end
