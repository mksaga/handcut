defmodule HandCutWebWeb.CuisineSelect do
  use HandCutWebWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="field is-horizontal">
        <div class="field-label">
        <label class="label"><%= @label %></label>
        </div>
        <div class="field-body"
        <div class="control">
            <div class="select is-multiple">
                <select multiple>
                  <%= for choice <- @options do %>
                    <option value={choice.value}><%= choice.label %></option>
                  <% end %>
                </select>
            </div>
        </div>
    </div>
    """
  end
end
