defmodule ExCms.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "admins" do
    field(:attributes, :map, default: %{})
    field(:email, :string)
    field(:full_name, :string)
    field(:is_active, :boolean, default: false)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:email, :password, :full_name, :is_active, :attributes])
    |> validate_required([:email, :password, :full_name, :is_active, :attributes])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> unique_constraint(:email)
  end
end
