defmodule GumHub.GitHubTest do
  use ExUnit.Case
  alias GumHub.GitHub
  alias GumHub.Fixtures

  describe "add_collaboratior_with_pull_permission/1" do
    test "success: adds collaborator" do
      github_config = %GitHub.Config{
        repo_owner: "github_owner",
        repo_name: "private-repo",
        token: "token"
      }

      Tesla.Mock.mock(fn
        %{method: :put} ->
          Fixtures.GitHub.successfully_added_collaborator()
      end)

      assert :ok ==
               GitHub.add_collaboratior_with_pull_permission(
                 "octocat",
                 github_config
               )
    end
  end
end
