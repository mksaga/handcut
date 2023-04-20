defmodule HandCut.Projections.Repo do
  use Ecto.Repo,
    otp_app: :hand_cut,
    adapter: Ecto.Adapters.Postgres
end
