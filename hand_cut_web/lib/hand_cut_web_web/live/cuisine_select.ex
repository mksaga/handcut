defmodule HandCutWebWeb.CuisineSelect do
  use HandCutWebWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="field is-horizontal">
        <div class="field-label">
        <label class="label">Cuisines</label>
        </div>
        <div class="field-body"
        <div class="control">
            <div class="select is-multiple">
                <%= multiple_select @form, :cuisines, @options, selected: Enum.map(@options, &(elem(&1, 1))) %>
            </div>
        </div>
    </div>
    """
  end
end
