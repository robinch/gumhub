defmodule GumHubTest do
  use ExUnit.Case
  import ExUnit.CaptureLog
  import Hammox
  alias GumHub.Gumroad
  alias GumHub.GitHub

  setup :verify_on_exit!

  test "successfully adds user with verified license" do
    MockGumroad
    |> expect(:verify_license, fn product_id, license ->
      assert product_id == "gumroad_product_id_1"
      assert license == "gumroad_license_1"

      {:ok, %Gumroad.License{uses: 1}}
    end)

    MockGitHub
    |> expect(:add_collaboratior_with_pull_permission, fn github_username_to_add, github_config ->
      assert github_username_to_add == "github_username_123"

      assert github_config ==
               %GitHub.Config{
                 repo_owner: "github_owner_1",
                 repo_name: "github_repo_1",
                 token: "github_token_1"
               }

      :ok
    end)

    assert :ok ==
             GumHub.give_verified_user_github_repo_access(
               "gumroad_product_id_1",
               "gumroad_license_1",
               "github_username_123"
             )
  end

  test "error: too many uses" do
    MockGumroad
    |> expect(:verify_license, fn _product_id, _license ->
      {:ok, %Gumroad.License{uses: 2}}
    end)

    log =
      capture_log(fn ->
        assert {:error, :too_many_uses} ==
                 GumHub.give_verified_user_github_repo_access(
                   "gumhub_product_id_1",
                   "gumhub_license_1",
                   "github_username_123"
                 )
      end)

    assert log =~ "[error] Too many uses (2) on license code 'gumhub_license_1'"
  end

  test "error: github config not found" do
    MockGumroad
    |> expect(:verify_license, fn product_id, license ->
      assert product_id == "unmapped_gumroad_product_id"
      assert license == "gumroad_license_1"

      {:ok, %Gumroad.License{uses: 1}}
    end)

    log =
      capture_log(fn ->
        assert {:error, :github_config_not_found} ==
                 GumHub.give_verified_user_github_repo_access(
                   "unmapped_gumroad_product_id",
                   "gumroad_license_1",
                   "github_username_123"
                 )
      end)

    assert log =~
             "[error] Could not find github config for gumroad product id 'unmapped_gumroad_product_id'"
  end
end
