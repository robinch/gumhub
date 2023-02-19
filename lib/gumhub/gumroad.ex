defmodule GumHub.Gumroad do
  alias GumHub.GumroadClient

  def verify_license(product_id, license) do
    with {:ok, %{status: 200, body: %{"success" => true, "uses" => 0}}} <-
           GumroadClient.verify_license(product_id, license) do
      :ok
    else
      {:ok, %{status: 200, body: %{"success" => true, "uses" => uses}}} when uses > 0 ->
        {:error, :too_many_uses}

      {:ok, %{status: 404, body: %{"success" => false}}} ->
        {:error, :license_not_found}
    end
  end
end
