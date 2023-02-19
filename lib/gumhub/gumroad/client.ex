defmodule GumHub.Gumroad.Client do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "https://api.gumroad.com"
  plug Tesla.Middleware.JSON
  plug Tesla.Middleware.Logger, log_level: &log_level/1

  def verify_license(product_id, license_key, increment_uses_count \\ true) do
    post("/v2/licenses/verify", %{
      "product_id" => product_id,
      "license_key" => license_key,
      "increment_uses_count" => increment_uses_count
    })
  end

  defp log_level(env) do
    case env.status do
      404 -> :info
      _ -> :default
    end
  end
end
