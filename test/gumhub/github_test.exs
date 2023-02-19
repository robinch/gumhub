defmodule GumHub.GithubTest do
  use ExUnit.Case
  alias GumHub.GitHub
  alias GumHub.Fixtures

  describe "add_collaboratior_with_pull_permission/1" do
    test "success: adds collaborator" do
      Tesla.Mock.mock(fn
        %{method: :put} ->
          Fixtures.GitHub.successfully_added_collaborator()
      end)

      assert :ok ==
               GitHub.add_collaboratior_with_pull_permission(
                 "github_owner",
                 "private-repo",
                 "octocat"
               )
    end
  end
end
