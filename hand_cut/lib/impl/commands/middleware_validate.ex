defmodule HandCut.Middleware.ValidateCommand do
  @behaviour Commanded.Middleware

  alias Commanded.Middleware.Pipeline
  alias HandCut.Middleware.CommandValidation

  @doc """
  Enrich the command via the opt-in command enrichment protocol.
  """
  def before_dispatch(%Pipeline{command: command} = pipeline) do
    {:ok, command}
    case CommandValidation.validate(command) do
      {:ok, command} ->
        %Pipeline{pipeline | command: command}

      {:error, _error} = reply ->
        pipeline
        |> Pipeline.respond(reply)
        |> Pipeline.halt()
    end
  end

  def after_dispatch(pipeline), do: pipeline

  def after_failure(pipeline), do: pipeline

end
