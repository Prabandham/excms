defmodule ExCms.Sites.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExCms.Sites.Site

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "assets" do
    field(:content, :string)
    field(:name, :string)
    field(:priority, :integer, default: 1)

    belongs_to(:site, Site)

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :content, :site_id, :priority])
    |> validate_required([:name, :content, :site_id])
    |> unique_constraint(:name_for_site, name: :name_for_site_assets)
  end
end
