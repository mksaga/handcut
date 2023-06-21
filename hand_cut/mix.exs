defmodule HandCut.MixProject do
  use Mix.Project

  def project do
    [
      app: :hand_cut,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: { HandCut.Runtime.Application, [] },
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      reset: ["event_store.drop", "event_store.create", "event_store.init"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:commanded, "~> 1.4"},
      {:commanded_ecto_projections, "~> 1.3"},
      {:commanded_eventstore_adapter, "~> 1.4"},
      {:ecto_sql, "~> 3.10"},
      {:eventstore, "~> 1.4"},
      {:jason, "~> 1.3"},
      {:nanoid, "~> 2.0.5"},
    ]
  end
end
