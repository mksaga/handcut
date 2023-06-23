alias HandCut.Commands.{CreateRestaurant, UpdateRestaurant}
alias HandCut.Commands.{CreateCertification}
alias HandCut.Runtime.App, as: HCApp

restaurant_id = "restaurant_" <> Nanoid.generate(6, "0123456789abcdefghijklmnopqrstuvwxyz")
cert_id = "certification_" <> Nanoid.generate(6, "0123456789abcdefghijklmnopqrstuvwxyz")
