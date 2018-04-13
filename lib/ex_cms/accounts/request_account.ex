defmodule ExCms.Accounts.RequestAccount do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "requests" do
    field(:email, :string)
    field(:message, :string)

    timestamps()
  end

  @doc false
  def changeset(request_account, attrs) do
    request_account
    |> cast(attrs, [:email, :message])
    |> validate_required([:email, :message])
    |> validate_format(:email, ~r/^[A-Za-z0-9._%+-+']+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/)
    |> unique_constraint(:email)
  end
end
