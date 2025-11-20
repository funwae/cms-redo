defmodule CodeMySpec.Repo.Migrations.CreateAccounts do
  use Ecto.Migration

  def change do
    create table(:accounts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string, null: false
      add :hashed_password, :string, null: false
      add :name, :string

      timestamps(type: :utc_datetime_usec)
    end

    create unique_index(:accounts, [:email])
  end
end
