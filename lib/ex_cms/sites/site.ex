defmodule ExCms.Sites.Site do
  use Ecto.Schema
  import Ecto.Changeset
  @moduledoc false

  alias ExCms.Sites.{Page, Asset, Layout}

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "sites" do
    field(:description, :string)
    field(:domain_name, :string)
    field(:google_analytics_key, :string)
    field(:is_active, :boolean, default: false)
    field(:meta, :map, default: %{})
    field(:name, :string)
    field(:root_page, :string)

    has_many(:layouts, Layout)
    has_many(:assets, Asset)
    has_many(:pages, Page)

    timestamps()
  end

  @doc false
  def changeset(site, attrs) do
    site
    |> cast(attrs, [
      :name,
      :is_active,
      :domain_name,
      :description,
      :meta,
      :google_analytics_key,
      :root_page
    ])
    |> validate_required([:name, :is_active, :domain_name, :description])
    |> unique_constraint(:name)
    |> unique_constraint(:domain_name)
  end
end
