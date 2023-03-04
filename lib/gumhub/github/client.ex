defmodule GumHub.GitHub.Client do
  @middleware [
    {Tesla.Middleware.BaseUrl, "https://api.github.com"},
    Tesla.Middleware.JSON,
    Tesla.Middleware.Logger
  ]

  def add_collaborator(repo_owner, repo_name, github_username_to_add, permission, token) do
    middleware = [{Tesla.Middleware.BearerAuth, token: token} | @middleware]
    client = Tesla.client(middleware)

    Tesla.put(
      client,
      "/repos/#{repo_owner}/#{repo_name}/collaborators/#{github_username_to_add}",
      %{permission: permission}
    )
  end
end
