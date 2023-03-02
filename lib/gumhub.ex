defmodule GumHub do
  alias GumHub.Gumroad
  require Logger

  @callback give_verified_user_github_repo_access(
              license_code :: binary(),
              github_username :: binary()
            ) :: :ok | {:error, :too_many_uses}
  def give_verified_user_github_repo_access(license_code, github_username) do
    with {:ok, %Gumroad.License{uses: uses}} when uses <= 1 <-
           gumroad().verify_license(product_id(), license_code),
         :ok <-
           github().add_collaboratior_with_pull_permission(
             repo_owner(),
             repo_name(),
             github_username
           ) do
      :ok
    else
      {:ok, %Gumroad.License{uses: uses}} when uses > 1 ->
        Logger.error("Too many uses (#{uses}) on license code (#{license_code})")
        {:error, :too_many_uses}
    end
  end

  defp product_id, do: Application.get_env(:gumhub, :gumroad_product_id)
  defp repo_owner, do: Application.get_env(:gumhub, :github_private_repo_owner)
  defp repo_name, do: Application.get_env(:gumhub, :github_private_repo_name)

  defp gumroad, do: Application.get_env(:gumhub, :gumroad, GumHub.Gumroad)
  defp github, do: Application.get_env(:gumhub, :github, GumHub.GitHub)
end
