defmodule CodeMySpec.Accounts.Account do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "accounts" do
    field :email, :string
    field :hashed_password, :string
    field :name, :string

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:email, :hashed_password, :name])
    |> validate_required([:email, :hashed_password])
    |> unique_constraint(:email)
  end
end

