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
                <select>
                  <%= for choice <- @options do %>
                    <option value={choice.value}><%= "(" <> choice.state <> ") " <> choice.name %></option>
                  <% end %>
                </select>
            </div>
        </div>
    </div>
    """
  end
end
