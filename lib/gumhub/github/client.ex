defmodule GumHub.GitHub.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.BearerAuth, token: Application.get_env(:gumhub, :github_api_token)
  plug Tesla.Middleware.Logger

  def add_collaborator(repo_owner, repo_name, github_username_to_add, permission) do
    put(
      "/repos/#{repo_owner}/#{repo_name}/collaborators/#{github_username_to_add}",
      %{permission: permission}
    )
  end
end
