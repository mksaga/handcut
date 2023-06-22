defmodule HandCut.Runtime.Server do
  def start_link do
    children = [
      HandCut.Runtime.App,
      HandCut.Projections.Repo,
      HandCut.Projectors.ActivationRequestProjector,
      HandCut.Projectors.RestaurantProjector,
      HandCut.Projectors.CertificationProjector,
      # HandCut.ProcessManagers.ActivationRequestProcessManager,
    ]

    opts = [strategy: :one_for_one, name: HandCut.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
