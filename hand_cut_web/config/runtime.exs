import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.

case config_env() do
  :dev ->
    Code.require_file("runtime.exs", "./hand_cut/config")
    Code.require_file("runtime.dev.exs", "config")
  :test -> Code.require_file("runtime.test.exs", "config")
  :prod ->
    Code.require_file("runtime.exs", "./hand_cut/config")
    Code.require_file("runtime.prod.exs", "config")
end
