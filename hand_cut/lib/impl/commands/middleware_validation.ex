defprotocol HandCut.Middleware.CommandValidation do
  @doc """
  Enrich a command with additional data during dispatch, before passing to aggregate.
  As an example, this is an extension point where additional data could be retreived
  from the database to enrich the command's fields.
  """
  @fallback_to_any true
  def validate(command)
end

defimpl HandCut.Middleware.CommandValidation, for: Any do
  @doc """
  By default the command is not modified.
  """
  def validate(command), do: {:ok, command}
end
