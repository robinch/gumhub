defmodule GumHub.GitHub do
  alias GumHub.GitHub

  @callback add_collaboratior_with_pull_permission(
              github_username_to_add :: binary(),
              github_config :: GitHub.Config.t()
            ) :: :ok
  def add_collaboratior_with_pull_permission(github_username_to_add, github_config) do
    {:ok, %{status: 201}} =
      GitHub.Client.add_collaborator(
        github_config.repo_owner,
        github_config.repo_name,
        github_username_to_add,
        "pull",
        github_config.token
      )

    :ok
  end
end
