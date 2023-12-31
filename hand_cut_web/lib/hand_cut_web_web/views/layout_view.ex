defmodule HandCutWebWeb.LayoutView do
  use HandCutWebWeb, :view
  alias HandCutWebWeb.Components

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def page_title(%{page_title: page_title}, default_title) when is_binary(page_title) do
    [page_title, default_title] |> Enum.join(" | ")
  end

  def page_title(_, default_title), do: default_title
end
