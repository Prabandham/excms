defmodule ExCms.AccountsTest do
  use ExCms.DataCase

  alias ExCms.Accounts

  describe "admins" do
    alias ExCms.Accounts.Admin

    @valid_attrs %{
      attributes: %{},
      email: "test@test.com",
      full_name: "some full_name",
      is_active: true,
      password: "some_password"
    }
    @update_attrs %{
      attributes: %{},
      email: "test@larks.in",
      full_name: "some updated full_name",
      is_active: false,
      password: "some_updated_password"
    }
    @invalid_attrs %{
      attributes: nil,
      email: nil,
      full_name: nil,
      is_active: nil,
      password_hash: nil
    }

    def admin_fixture(attrs \\ %{}) do
      {:ok, admin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_admin()

      admin
    end

    test "list_admins/0 returns all admins" do
      admin = admin_fixture()
      admin = Map.put(admin, :password, nil)
      assert Accounts.list_admins() == [admin]
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      admin = Map.put(admin, :password, nil)
      assert Accounts.get_admin!(admin.id) == admin
    end

    test "create_admin/1 with valid data creates a admin" do
      assert {:ok, %Admin{} = admin} = Accounts.create_admin(@valid_attrs)
      assert admin.attributes == %{}
      assert admin.email == "test@test.com"
      assert admin.full_name == "some full_name"
      assert admin.is_active == true
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()
      assert {:ok, admin} = Accounts.update_admin(admin, @update_attrs)
      assert %Admin{} = admin
      assert admin.attributes == %{}
      assert admin.email == "test@larks.in"
      assert admin.full_name == "some updated full_name"
      assert admin.is_active == false
    end

    test "update_admin/2 with invalid data returns error changeset" do
      admin = admin_fixture()
      admin = Map.put(admin, :password, nil)
      assert {:error, %Ecto.Changeset{}} = Accounts.update_admin(admin, @invalid_attrs)
      assert admin == Accounts.get_admin!(admin.id)
    end

    test "delete_admin/1 deletes the admin" do
      admin = admin_fixture()
      assert {:ok, %Admin{}} = Accounts.delete_admin(admin)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_admin!(admin.id) end
    end

    test "change_admin/1 returns a admin changeset" do
      admin = admin_fixture()
      assert %Ecto.Changeset{} = Accounts.change_admin(admin)
    end
  end

  describe "requests" do
    alias ExCms.Accounts.RequestAccount

    @valid_attrs %{email: "test@test.com", message: "some message"}
    @update_attrs %{email: "test@larks.in", message: "some updated message"}
    @invalid_attrs %{email: nil, message: nil}

    def request_account_fixture(attrs \\ %{}) do
      {:ok, request_account} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_request_account()

      request_account
    end

    test "list_requests/0 returns all requests" do
      request_account = request_account_fixture()
      assert Accounts.list_requests() == [request_account]
    end

    test "get_request_account!/1 returns the request_account with given id" do
      request_account = request_account_fixture()
      assert Accounts.get_request_account!(request_account.id) == request_account
    end

    test "create_request_account/1 with valid data creates a request_account" do
      assert {:ok, %RequestAccount{} = request_account} =
               Accounts.create_request_account(@valid_attrs)

      assert request_account.email == "test@test.com"
      assert request_account.message == "some message"
    end

    test "create_request_account/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_request_account(@invalid_attrs)
    end

    test "update_request_account/2 with valid data updates the request_account" do
      request_account = request_account_fixture()

      assert {:ok, request_account} =
               Accounts.update_request_account(request_account, @update_attrs)

      assert %RequestAccount{} = request_account
      assert request_account.email == "test@larks.in"
      assert request_account.message == "some updated message"
    end

    test "update_request_account/2 with invalid data returns error changeset" do
      request_account = request_account_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_request_account(request_account, @invalid_attrs)

      assert request_account == Accounts.get_request_account!(request_account.id)
    end

    test "delete_request_account/1 deletes the request_account" do
      request_account = request_account_fixture()
      assert {:ok, %RequestAccount{}} = Accounts.delete_request_account(request_account)

      assert_raise Ecto.NoResultsError, fn ->
        Accounts.get_request_account!(request_account.id)
      end
    end

    test "change_request_account/1 returns a request_account changeset" do
      request_account = request_account_fixture()
      assert %Ecto.Changeset{} = Accounts.change_request_account(request_account)
    end
  end
end
