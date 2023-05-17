defmodule HandCutWebWeb.SearchUI do
  use Phoenix.Component


  def select(assigns) do
    ~H"""
    <div class="field is-horizontal">
        <div class="field-label">
        <label class="label"><%= @label %></label>
        </div>
        <div class="field-body"
        <div class="control">
            <div class="select">
                <select>
                  <%= for choice <- @options do %>
                    <option value={choice.value}><%= choice.label %></option>
                  <% end %>
                </select>
            </div>
        </div>
    </div>
    """
  end

  def multi_select(assigns) do
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

  def submit(assigns) do
    ~H"""
    <div class="field">
      <div class="control">
        <button class="button is-link">Submit</button>
      </div>
    </div>
    """
  end
end
