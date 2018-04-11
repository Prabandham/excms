defmodule ExCms.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :password_hash, :string
      add :full_name, :string
      add :is_active, :boolean, default: false, null: false
      add :attributes, :map, default: "{}"

      timestamps()
    end

    create unique_index(:admins, [:email])
  end
end
