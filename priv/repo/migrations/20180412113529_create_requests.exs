defmodule ExCms.Repo.Migrations.CreateRequests do
  use Ecto.Migration

  def change do
    create table(:requests, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string
      add :message, :text

      timestamps()
    end

    create unique_index(:requests, [:email])
  end
end
