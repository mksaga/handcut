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
                    <a href="/about" class="mr-2">About</a>
                    <.button href="/search" text="Search" />
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

  def cuisine_class(cuisine) do
    color =
      case cuisine do
        c when c in [:thai, "thai"] -> "is-success"
      end

    "tag is-light mt-1 " <> color
  end

  def cuisine_label(assigns) do
    ~H"""
    <span class={cuisine_class(@cuisine)}>
      <%= @cuisine |> String.capitalize() %>
    </span>
    """
  end

  def atom_cuisine_label(assigns) do
    ~H"""
    <span class={cuisine_class(@cuisine)}>
      <%= @cuisine |> Atom.to_string() |> String.capitalize() %>
    </span>
    """
  end

  defp humanize_certification_type(type) do
    case type do
      "certified_hand_slaughtered" -> "Certified Hand Slaughtered"
      :certified_hand_slaughtered -> "Certified Hand Slaughtered"
      "certified_machine_slaughtered" -> "Certified Machine Slaughtered"
      :certified_machine_slaughtered -> "Certified Machine Slaughtered"
    end
  end

  def certification_class(type) do
    color =
      case type do
        t when t in [:certified_hand_slaughtered, "certified_hand_slaughtered"] -> "is-success"
        t when t in [:certified_machine_slaughtered, "certified_machine_slaughtered"] -> "is-warning"
      end

    "tag is-light mt-1 " <> color
  end

  def certification_label(assigns) do
    ~H"""
    <span class={certification_class(@certification.type)}>
      <p><%= @certification.type |> humanize_certification_type() %></p>
    </span>
    """
  end
end
