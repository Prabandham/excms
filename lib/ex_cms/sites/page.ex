defmodule ExCms.Sites.Page do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExCms.Sites.{Site, Layout}


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "pages" do
    field :content, :string
    field :description, :string
    field :is_active, :boolean, default: false
    field :name, :string
    field :title, :string

    belongs_to :site, Site
    belongs_to :layout, Layout

    timestamps()
  end

  @doc false
  def changeset(pages, attrs) do
    pages
    |> cast(attrs, [:name, :is_active, :description, :content, :title, :layout_id, :site_id])
    |> validate_required([:name, :is_active, :description, :content, :title, :layout_id, :site_id])
    |> unique_constraint(:name, name: :name_for_site_pages)
  end
end
