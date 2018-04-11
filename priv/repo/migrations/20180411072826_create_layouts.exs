defmodule ExCms.Repo.Migrations.CreateLayouts do
  use Ecto.Migration

  def change do
    create table(:layouts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :content, :text
      add :site_id, references(:sites, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:layouts, [:name, :site_id], name: :name_for_site_layouts)
    create index(:layouts, [:site_id])
  end
end
