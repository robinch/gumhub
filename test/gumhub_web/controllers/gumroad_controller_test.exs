defmodule GumHubWeb.GumroadControllerTest do
  use GumHubWeb.ConnCase

  import Hammox

  setup :verify_on_exit!

  test "POST /gumroad/ping", %{conn: conn} do
    MockGumHub
    |> expect(:give_verified_user_github_repo_access, fn license_key, github_username ->
      assert license_key == "license_key_123"
      assert github_username == "github_username_123"

      :ok
    end)

    body = %{
      "license_key" => "license_key_123",
      "custom_fields" => Jason.encode!(%{"Github Username" => "github_username_123"})
    }

    conn = post(conn, ~p"/gumroad/ping", body)

    assert response(conn, 200) == "ok"
  end
end
