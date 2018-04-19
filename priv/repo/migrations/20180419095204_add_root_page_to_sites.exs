defmodule ExCms.Repo.Migrations.AddRootPageToSites do
  use Ecto.Migration

  def change do
    alter table("sites") do
      add :root_page, :text
    end
  end
end
