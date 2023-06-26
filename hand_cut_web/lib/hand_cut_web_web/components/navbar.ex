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
                    <.button href="/about" text="About" class="mr-2" />
                    <.button href="/search" text="Search" />
            </div>
        </div>
    """
  end

  def button(assigns) do
    ~H"""
    <a href={@href} class={Map.get(assigns, :class, "")}>
          <button class="button is-link is-light">
          <%= @text %>
          </button>
      </a>
    """
  end

  # Map each cuisine to a color from here
  # https://bulma.io/documentation/elements/tag/#colors
  def cuisine_class(cuisine) do
    color =
      case cuisine do
        c when c in [:thai, "thai"] -> "is-success"
        c when c in [:bengali, "bengali"] -> "is-success"
        c when c in [:pakistani, "pakistani"] -> "is-success"
        c when c in [:indian, "indian"] -> "is-warning"
        c when c in [:chinese, "chinese"] -> "is-danger"
        c when c in [:mexican, "mexican"] -> "is-warning"
        c when c in [:afghani, "afghani"] -> "is-danger"
        c when c in [:turkish, "turkish"] -> "is-danger"
        c when c in [:middle_eastern, "middle_eastern"] -> "is-danger"
        c when c in [:american, "american"] -> "is-danger"
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

  def humanize_certification_type(type) do
    case type do
      "certified_hand_slaughtered" -> "Certified Hand Slaughtered"
      :certified_hand_slaughtered -> "Certified Hand Slaughtered"
      "certified_machine_slaughtered" -> "Certified Machine Slaughtered"
      :certified_machine_slaughtered -> "Certified Machine Slaughtered"
      :all -> "All"
        t when t in [:certified_hand_slaughtered, "certified_hand_slaughtered"] -> "Certified Hand Slaughtered"
        t when t in [:certified_machine_slaughtered, "certified_machine_slaughtered"] -> "Certified Machine Slaughtered"
        t when t in [:all, "all"] -> "All"
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
