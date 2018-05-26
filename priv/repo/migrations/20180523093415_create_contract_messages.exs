defmodule ExCms.Repo.Migrations.CreateContractMessages do
  use Ecto.Migration

  def change do
    create table(:contact_messages, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :values, :map, default: %{}
      add :site_id, references(:sites, on_delete: :nothing, type: :binary_id)

      timestamps()
    end

    create index(:contact_messages, [:site_id])
  end
end
