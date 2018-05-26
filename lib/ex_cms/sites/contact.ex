defmodule ExCms.Sites.Contact do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "contact_messages" do
    field :values, :map
    field :site_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:values, :site_id])
    |> validate_required([:values, :site_id])
  end
end
