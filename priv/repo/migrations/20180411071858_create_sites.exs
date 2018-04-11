defmodule ExCms.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:sites, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :is_active, :boolean, default: false, null: false
      add :domain_name, :string
      add :description, :text
      add :meta, :map
      add :google_analytics_key, :string

      timestamps()
    end

    create unique_index(:sites, [:name])
    create unique_index(:sites, [:domain_name])
  end
end
