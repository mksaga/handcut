defmodule HandCut.Projections.Repo.Migrations.AddTimestampsToRestaurants do
  use Ecto.Migration

  def up do
    alter table(:restaurants) do
      timestamps(null: true)
    end

    execute("""
    UPDATE restaurants
    SET updated_at=NOW(), inserted_at=NOW()
    """)

    alter table(:restaurants) do
      modify(:inserted_at, :utc_datetime, null: false)
      modify(:updated_at, :utc_datetime, null: false)
    end
  end

  def down do
    alter table(:restaurants) do
      remove(:inserted_at)
      remove(:updated_at)
    end
  end
end
