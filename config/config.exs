# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :gumhub,
  namespace: GumHub,
  gumroad_product_id: System.get_env("GUMROAD_PRODUCT_ID"),
  github_api_token: System.get_env("GITHUB_API_TOKEN"),
  github_private_repo_owner: System.get_env("GITHUB_PRIVATE_REPO_OWNER"),
  github_private_repo_name: System.get_env("GITHUB_PRIVATE_REPO_NAME")

# Configures the endpoint
config :gumhub, GumHubWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: GumHubWeb.ErrorHTML, json: GumHubWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: GumHub.PubSub,
  live_view: [signing_salt: "tZs0QnZk"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :tesla, :adapter, Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
