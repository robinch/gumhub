defmodule GumHub.Gumroad do
  alias GumHub.Gumroad
  require Logger

  @callback verify_license(product_id :: binary(), license_code :: binary()) ::
              {:ok, Gumroad.License.t()} | {:error, :license_not_found}
  def verify_license(product_id, license_code) do
    with {:ok, %{status: 200, body: %{"success" => true, "uses" => uses}}} <-
           Gumroad.Client.verify_license(product_id, license_code) do
      {:ok, %Gumroad.License{uses: uses}}
    else
      {:ok, %{status: 404, body: %{"success" => false}}} ->
        Logger.error("License (#{license_code}) not found")
        {:error, :license_not_found}
    end
  end
end
