alias EventStore.EventData
alias HandCut.EventStore

defmodule RestaurantAddedEvent do
  defstruct [
    :name,
    :address,
    :area,
    :cuisine,
    :url,
    :instagram,
  ]
end

# events = [
#   %EventData{
#     event_type: RestaurantAddedEvent |> to_string(),
#     data: %RestaurantAddedEvent{
#       name: "Thai Spot",
#       address: "123 Main St, New York, NY 92929",
#       area: "New York",
#       cuisine: "Thai",
#       url: "thaispot.com",
#       instagram: "thatthaispot",
#     },
#     metadata: %{user: "me@example.com"},
#   }
# ]
