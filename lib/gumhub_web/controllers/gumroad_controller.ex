defmodule GumHubWeb.GumroadController do
  use GumHubWeb, :controller

  require Logger

  def ping(conn, %{
        "product_id" => product_id,
        "license_key" => license_key,
        "GitHub Username" => github_username
      }) do
    :ok = gumhub().give_verified_user_github_repo_access(product_id, license_key, github_username)
    send_resp(conn, 200, "ok")
  end

  defp gumhub, do: Application.get_env(:gumhub, :gumhub, GumHub)
end
