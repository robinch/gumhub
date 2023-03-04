defmodule GumHub do
  alias GumHub.Gumroad
  alias GumHub.Mappings
  require Logger

  @callback give_verified_user_github_repo_access(
              product_id :: binary(),
              license_code :: binary(),
              github_username :: binary()
            ) :: :ok | {:error, :too_many_uses}
  def give_verified_user_github_repo_access(product_id, license_code, github_username) do
    with {:ok, %Gumroad.License{uses: uses}} when uses <= 1 <-
           gumroad().verify_license(product_id, license_code),
         {:ok, github_config} <- Mappings.get_github_config(product_id),
         :ok <-
           github().add_collaboratior_with_pull_permission(
             github_username,
             github_config
           ) do
      :ok
    else
      {:ok, %Gumroad.License{uses: uses}} when uses > 1 ->
        Logger.error("Too many uses (#{uses}) on license code '#{license_code}'")
        {:error, :too_many_uses}

      {:error, :github_config_not_found} ->
        Logger.error("Could not find github config for gumroad product id '#{product_id}'")
        {:error, :github_config_not_found}
    end
  end

  defp gumroad, do: Application.get_env(:gumhub, :gumroad, GumHub.Gumroad)
  defp github, do: Application.get_env(:gumhub, :github, GumHub.GitHub)
end
