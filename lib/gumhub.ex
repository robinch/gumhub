defmodule GumHub do
  @moduledoc """
  GumHub keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias GumHub.GitHub
  alias GumHub.Gumroad

  def give_verified_user_github_repo_access(license, github_username) do
    with :ok <- Gumroad.verify_license(product_id(), license),
         :ok <-
           GitHub.add_collaboratior_with_pull_permission(
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
end
