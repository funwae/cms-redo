defmodule CodeMySpec.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias CodeMySpec.Repo
  alias CodeMySpec.Accounts.Account

  @doc """
  Creates a user.
  """
  def create_user(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a user and raises on error.
  """
  def create_user!(attrs \\ %{}) do
    %Account{}
    |> Account.changeset(attrs)
    |> Repo.insert!()
  end

  @doc """
  Gets a single user.
  """
  def get_user!(id), do: Repo.get!(Account, id)

  @doc """
  Gets a user by email.
  """
  def get_user_by_email(email) do
    Repo.get_by(Account, email: email)
  end

  @doc """
  Authenticates a user with email and password.
  """
  def authenticate_user(email, _password) do
    # STUB: For now, just return the user if they exist
    get_user_by_email(email)
  end
end

