defmodule ExCms.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admins" do
    field :attributes, :map, default: %{}
    field :email, :string
    field :full_name, :string
    field :is_active, :boolean, default: false
    field :password_hash, :string

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:email, :password_hash, :full_name, :is_active, :attributes])
    |> validate_required([:email, :password_hash, :full_name, :is_active, :attributes])
    |> unique_constraint(:email)
  end
end
