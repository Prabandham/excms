defmodule ExCms.Sites.Layout do
  use Ecto.Schema
  import Ecto.Changeset
  @moduledoc false

  alias ExCms.Sites.Site

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "layouts" do
    field(:content, :string)
    field(:name, :string)

    belongs_to(:site, Site)

    timestamps()
  end

  @doc false
  def changeset(layout, attrs) do
    layout
    |> cast(attrs, [:name, :content, :site_id])
    |> validate_required([:name, :content, :site_id])
    |> unique_constraint(:name, name: :name_for_site_layouts)
  end
end
