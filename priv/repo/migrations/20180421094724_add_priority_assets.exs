defmodule ExCms.Repo.Migrations.AddPriorityAssets do
  use Ecto.Migration

  def change do
    alter table("assets") do
      add :priority, :integer, default: 1
    end
  end
end
