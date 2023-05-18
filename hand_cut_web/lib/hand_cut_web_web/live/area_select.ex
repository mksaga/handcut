defmodule HandCutWebWeb.AreaSelect do
  use HandCutWebWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="field is-horizontal">
        <div class="field-label">
        <label class="label">Locations</label>
        </div>
        <div class="field-body"
        <div class="control">
            <div class="select">
                <%= select @form, :area, @options %>
            </div>
        </div>
    </div>
    """
  end
end
