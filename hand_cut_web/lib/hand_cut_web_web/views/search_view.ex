defmodule HandCutWebWeb.SearchView do
  alias HandCutWebWeb.SearchUI

  use HandCutWebWeb, :view

    def options() do
    [
      %{
        :value => "nj_jersey_city",
        :label => "(NJ) Jersey City"
      }
    ]
  end

end
