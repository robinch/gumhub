defmodule GumHubWeb.GumroadController do
  use GumHubWeb, :controller

  def ping(conn, params) do
    # TODO: Remove this this IO.inspect after verifying that it works
    IO.inspect(params, label: "------- /gumroad/ping PARAMS -------")

    license_key = params["license_key"]
    github_username = parse_github_username(params)

    :ok = gumhub().give_verified_user_github_repo_access(license_key, github_username)
    send_resp(conn, 200, "ok")
  end

  defp parse_github_username(%{"custom_fields" => custom_fields}) do
    Jason.decode!(custom_fields)
    |> Map.get("Github Username")
  end

  defp gumhub, do: Application.get_env(:gumhub, :gumhub, GumHub)
end
