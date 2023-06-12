defmodule HandCutWebWeb.CertificationSelect do
  use HandCutWebWeb, :live_component

  def render(assigns) do
    ~H"""
    <div class="field is-horizontal">
        <div class="field-label">
        <label class="label">Certification Type</label>
        </div>
        <div class="field-body"
        <div class="control">
            <div class="select">
                <%= select @form, :certification_type, @options %>
            </div>
        </div>
    </div>
    """
  end
end
