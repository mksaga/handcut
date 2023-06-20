defmodule HandCutWebWeb.CertificationSelect do
  use HandCutWebWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="field">
      <label class="label">Certification Type</label>
      <div class="control">
        <div class="select">
          <%= select @form, :certification_type, @options %>
        </div>
      </div>
    </div>
    """
  end
end
