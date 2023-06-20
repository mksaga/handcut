defmodule HandCutWebWeb.AreaSelect do
  use HandCutWebWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="field">
      <label class="label">Area</label>
      <div class="control">
        <div class="select">
          <%= select @form, :area, @options , class: "select" %>
        </div>
      </div>
    </div>
    """
  end
end
