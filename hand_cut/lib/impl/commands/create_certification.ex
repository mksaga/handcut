defmodule HandCut.Commands.CreateCertification do
  defstruct [
    :id,
    :restaurant_id,
    :type,
    :products,
    :expiration,
    :issuing_agency,
  ]
end
