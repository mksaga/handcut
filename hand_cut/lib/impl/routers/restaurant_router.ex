defmodule HandCut.RestaurantRouter do
  use Commanded.Commands.Router
  identify Restaurant, by: :id

  dispatch [CreateRestaurant], to: Restaurant
end
