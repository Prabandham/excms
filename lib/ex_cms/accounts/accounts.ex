defmodule ExCms.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias ExCms.Repo

  alias ExCms.Accounts.Admin

  @doc """
  Returns the list of admins.

  ## Examples

      iex> list_admins()
      [%Admin{}, ...]

  """
  def list_admins do
    Repo.all(Admin)
  end

  @doc """
  Gets a single admin.

  Raises `Ecto.NoResultsError` if the Admin does not exist.

  ## Examples

      iex> get_admin!(123)
      %Admin{}

      iex> get_admin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_admin!(id), do: Repo.get!(Admin, id)

  def get_admin_by_email(email) do
    Admin
    |> Repo.get_by(email: email)
  end

  @doc """
  Creates a admin.

  ## Examples

      iex> create_admin(%{field: value})
      {:ok, %Admin{}}

      iex> create_admin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_admin(attrs \\ %{}) do
    %Admin{}
    |> Admin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a admin.

  ## Examples

      iex> update_admin(admin, %{field: new_value})
      {:ok, %Admin{}}

      iex> update_admin(admin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_admin(%Admin{} = admin, attrs) do
    admin
    |> Admin.update_changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Admin.

  ## Examples

      iex> delete_admin(admin)
      {:ok, %Admin{}}

      iex> delete_admin(admin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_admin(%Admin{} = admin) do
    Repo.delete(admin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking admin changes.

  ## Examples

      iex> change_admin(admin)
      %Ecto.Changeset{source: %Admin{}}

  """
  def change_admin(%Admin{} = admin) do
    Admin.changeset(admin, %{})
  end

  alias ExCms.Accounts.RequestAccount

  @doc """
  Returns the list of requests.

  ## Examples

      iex> list_requests()
      [%RequestAccount{}, ...]

  """
  def list_requests do
    Repo.all(RequestAccount)
  end

  @doc """
  Gets a single request_account.

  Raises `Ecto.NoResultsError` if the Request account does not exist.

  ## Examples

      iex> get_request_account!(123)
      %RequestAccount{}

      iex> get_request_account!(456)
      ** (Ecto.NoResultsError)

  """
  def get_request_account!(id), do: Repo.get!(RequestAccount, id)

  @doc """
  Creates a request_account.

  ## Examples

      iex> create_request_account(%{field: value})
      {:ok, %RequestAccount{}}

      iex> create_request_account(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_request_account(attrs \\ %{}) do
    %RequestAccount{}
    |> RequestAccount.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a request_account.

  ## Examples

      iex> update_request_account(request_account, %{field: new_value})
      {:ok, %RequestAccount{}}

      iex> update_request_account(request_account, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_request_account(%RequestAccount{} = request_account, attrs) do
    request_account
    |> RequestAccount.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RequestAccount.

  ## Examples

      iex> delete_request_account(request_account)
      {:ok, %RequestAccount{}}

      iex> delete_request_account(request_account)
      {:error, %Ecto.Changeset{}}

  """
  def delete_request_account(%RequestAccount{} = request_account) do
    Repo.delete(request_account)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking request_account changes.

  ## Examples

      iex> change_request_account(request_account)
      %Ecto.Changeset{source: %RequestAccount{}}

  """
  def change_request_account(%RequestAccount{} = request_account) do
    RequestAccount.changeset(request_account, %{})
  end
end
