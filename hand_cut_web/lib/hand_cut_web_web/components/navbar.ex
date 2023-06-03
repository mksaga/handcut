defmodule HandCutWebWeb.Components do
  use Phoenix.Component

  def navbar(assigns) do
    ~H"""
        <div class="navbar is-fixed-top level is-mobile">
            <div class="level-left ml-2">
                <a href="/search">
                    <span class="is-size-5">HandCut</span>
                </a>
            </div>

            <div class="level-right mr-2">
                    <.button href="/search" text="Search" />
                    <.button href="/suggest" class="ml-2" text="Suggest" />
                    <.button href="/favorites" class="ml-2" text="Favorites" />
            </div>
        </div>
    """
  end

  def button(assigns) do
    ~H"""
    <a href={@href} class={Map.get(assigns, :class, "")}>
          <button class="button is-small is-link is-light">
          <%= @text %>
          </button>
      </a>
    """
  end

  def cuisine_label(assigns) do
    ~H"""
    <span class="tag is-info is-light">
      <%= @cuisine |> String.capitalize() %>
    </span>
    """
  end
end