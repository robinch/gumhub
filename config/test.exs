import Config

config :gumhub,
  github: MockGitHub,
  github_api_token: "github_api_token_123",
  github_private_repo_owner: "github_repo_owner_123",
  github_private_repo_name: "github_repo_name_123",
  gumhub: MockGumHub,
  gumroad: MockGumroad,
  gumroad_product_id: "product_id_123"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gumhub, GumHubWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "Lb3ngWq3+3q0P9GN0TzhZ+C/AUhrWXRQspGEv6NGM31itgsDfiSUNRAa0zum5umj",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

config :tesla, adapter: Tesla.Mock
