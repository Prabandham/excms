
defmodule ExCms.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :is_active, :boolean, default: false, null: false
      add :description, :text
      add :content, :text
      add :title, :string
      add :layout_id, references(:layouts, on_delete: :nothing, type: :binary_id)
      add :site_id, references(:sites, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create unique_index(:pages, [:name, :site_id], name: :name_for_site_pages)
    create index(:pages, [:site_id, :layout_id])
  end
end
