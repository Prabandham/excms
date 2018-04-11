defmodule ExCms.Repo.Migrations.CreateAssets do
  use Ecto.Migration

  def change do
    create table(:assets, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :content, :text
      add :site_id, references(:sites, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:assets, [:name, :site_id], name: :name_for_site_assets)
    create index(:assets, [:site_id])
  end
end
