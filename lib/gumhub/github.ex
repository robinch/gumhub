defmodule GumHub.GitHub do
  alias GumHub.GitHub

  def add_collaboratior_with_pull_permission(repo_owner, repo_name, github_username_to_add) do
    {:ok, %{status: 201}} =
      GitHub.Client.add_collaborator(
        repo_owner,
        repo_name,
        github_username_to_add,
        "pull"
      )

    :ok
  end
end
