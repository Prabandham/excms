defmodule ExCms.Sites.Contact do
  use Ecto.Schema
  import Ecto.Changeset
  @moduledoc false

  alias ExCms.Sites.Site

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contact_messages" do
    field(:values, :map)

    belongs_to(:site, Site)
    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:values, :site_id])
    |> validate_required([:values, :site_id])
  end
end
