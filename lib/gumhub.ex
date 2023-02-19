defmodule GumHub do
  @callback give_verified_user_github_repo_access(
              license :: binary(),
              github_username :: binary()
            ) :: :ok | {:error, :too_many_uses | :license_not_found}
  def give_verified_user_github_repo_access(license, github_username) do
    with :ok <- gumroad().verify_license(product_id(), license),
         :ok <-
           github().add_collaboratior_with_pull_permission(
             repo_owner(),
             repo_name(),
             github_username
           ) do
      :ok
    end
  end

  defp product_id, do: Application.get_env(:gumhub, :gumroad_product_id)
  defp repo_owner, do: Application.get_env(:gumhub, :github_private_repo_owner)
  defp repo_name, do: Application.get_env(:gumhub, :github_private_repo_name)

  defp gumroad, do: Application.get_env(:gumhub, :gumroad, GumHub.Gumroad)
  defp github, do: Application.get_env(:gumhub, :github, GumHub.GitHub)
end
