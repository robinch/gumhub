defmodule GumHub.MappingsTest do
  use ExUnit.Case
  alias GumHub.Mappings
  alias GumHub.GitHub

  describe "gihub_config/1" do
    test "can fetch multi different GitHub configs" do
      assert Mappings.get_github_config("gumroad_product_id_1") ==
               {:ok,
                %GitHub.Config{
                  repo_owner: "github_owner_1",
                  repo_name: "github_repo_1",
                  token: "github_token_1"
                }}

      assert Mappings.get_github_config("gumroad_product_id_2") ==
               {:ok,
                %GitHub.Config{
                  repo_owner: "github_owner_2",
                  repo_name: "github_repo_2",
                  token: "github_token_2"
                }}
    end

    test "error: no GitHub config found under Gumroad product id" do
      assert Mappings.get_github_config("gumroad_product_id_unknown") ==
               {:error, :github_config_not_found}
    end
  end
end
