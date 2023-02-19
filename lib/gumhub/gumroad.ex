defmodule GumHub.Gumroad do
  alias GumHub.Gumroad

  require Logger

  @callback verify_license(product_id :: binary(), license :: binary()) ::
              :ok | {:error, :too_many_uses | :license_not_found}
  def verify_license(product_id, license) do
    with {:ok, %{status: 200, body: %{"success" => true, "uses" => 1}}} <-
           Gumroad.Client.verify_license(product_id, license) do
      :ok
    else
      {:ok, %{status: 200, body: %{"success" => true, "uses" => uses}}} when uses > 1 ->
        Logger.error("Too many uses (#{uses}) on license (#{license})")
        {:error, :too_many_uses}

      {:ok, %{status: 404, body: %{"success" => false}}} ->
        Logger.error("License (#{license}) not found")
        {:error, :license_not_found}
    end
  end
end
