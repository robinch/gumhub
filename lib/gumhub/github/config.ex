defmodule GumHub.GitHub.Config do
  defstruct [:repo_owner, :repo_name, :token]

  @type t :: %__MODULE__{repo_owner: binary | nil, repo_name: binary | nil, token: binary | nil}
end
