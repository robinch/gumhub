defmodule GumHub.Mappings do
  alias GumHub.GitHub

  def get_github_config(gumroad_product_id) do
    case Map.get(mappings(), gumroad_product_id) do
      nil -> {:error, :github_config_not_found}
      github_config -> {:ok, github_config}
    end
  end

  defp mappings() do
    Application.get_env(:gumhub, :gumroad_to_github_mappings)
    |> Enum.map(fn mapping ->
      [gumroad_product_id, github_owner, github_repo, github_token] = String.split(mapping, ":")

      {gumroad_product_id,
       %GitHub.Config{
         repo_owner: github_owner,
         repo_name: github_repo,
         token: github_token
       }}
    end)
    |> Enum.into(%{})
  end
end
