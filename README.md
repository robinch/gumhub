# GumHub

GumHub is an integration between Gumroad and Github that will give users that purchases your product on Gumroad access to a private repository on Github that you own.

You can test the integration here: https://robinch.gumroad.com/l/gnudi

This project was inspired by this article: https://makerkit.dev/blog/tutorials/sell-code-gumroad-github

# Environment Variables

The following environment variables needs to be set

- GUMROAD_PRODUCT_ID
- GITHUB_API_TOKEN
- GITHUB_PRIVATE_REPO_OWNER
- GITHUB_PRIVATE_REPO_NAME

## Running the application locally

To start your Phoenix server:

- Run `mix setup` to install and setup dependencies
- Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

- Official website: https://www.phoenixframework.org/
- Guides: https://hexdocs.pm/phoenix/overview.html
- Docs: https://hexdocs.pm/phoenix
- Forum: https://elixirforum.com/c/phoenix-forum
- Source: https://github.com/phoenixframework/phoenix
