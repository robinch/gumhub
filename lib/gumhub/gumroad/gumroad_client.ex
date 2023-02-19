defmodule GumHub.GumroadClient do
  use Tesla

  require Logger

  plug Tesla.Middleware.BaseUrl, "https://api.gumroad.com"
  plug Tesla.Middleware.Logger, log_level: &log_level/1
  plug Tesla.Middleware.JSON

  def verify_license(product_id, license_key, increment_uses_count \\ true) do
    with {:ok, %Tesla.Env{} = response} <-
           post("/v2/licenses/verify", %{
             "product_id" => product_id,
             "license_key" => license_key,
             "increment_uses_count" => increment_uses_count
           }) do
      {:ok, response}
    end
  end

  defp log_level(env) do
    case env.status do
      404 -> :info
      _ -> :default
    end
  end
end
