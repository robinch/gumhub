defmodule GumHub.GitHub do
  alias GumHub.GitHub

  def add_collaboratior_with_pull_permission(github_username_to_add) do
    {:ok, %{status: 201}} =
      GitHub.Client.add_collaborator(
        repo_owner(),
        repo_name(),
        github_username_to_add,
        "pull"
      )

    :ok
  end

  defp repo_owner, do: Application.get_env(:gumhub, :github_private_repo_owner)
  defp repo_name, do: Application.get_env(:gumhub, :github_private_repo_name)
end
