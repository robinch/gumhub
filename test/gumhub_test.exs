defmodule GumHubTest do
  use ExUnit.Case

  import Hammox

  setup :verify_on_exit!

  test "successfully adds user with verified license" do
    MockGumroad
    |> expect(:verify_license, fn product_id, license ->
      assert product_id == "product_id_123"
      assert license == "license_123"

      :ok
    end)

    MockGitHub
    |> expect(:add_collaboratior_with_pull_permission, fn github_owner,
                                                          github_repo,
                                                          github_username_to_add ->
      assert github_owner == "github_repo_owner_123"
      assert github_repo == "github_repo_name_123"
      assert github_username_to_add == "github_username_123"

      :ok
    end)

    assert :ok ==
             GumHub.give_verified_user_github_repo_access("license_123", "github_username_123")
  end
end
