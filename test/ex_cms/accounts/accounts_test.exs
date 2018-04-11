defmodule ExCms.AccountsTest do
  use ExCms.DataCase

  alias ExCms.Accounts

  describe "admins" do
    alias ExCms.Accounts.Admin

    @valid_attrs %{attributes: %{}, email: "some email", full_name: "some full_name", is_active: true, password_hash: "some password_hash"}
    @update_attrs %{attributes: %{}, email: "some updated email", full_name: "some updated full_name", is_active: false, password_hash: "some updated password_hash"}
    @invalid_attrs %{attributes: nil, email: nil, full_name: nil, is_active: nil, password_hash: nil}

    def admin_fixture(attrs \\ %{}) do
      {:ok, admin} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_admin()

      admin
    end

    test "list_admins/0 returns all admins" do
      admin = admin_fixture()
      assert Accounts.list_admins() == [admin]
    end

    test "get_admin!/1 returns the admin with given id" do
      admin = admin_fixture()
      assert Accounts.get_admin!(admin.id) == admin
    end

    test "create_admin/1 with valid data creates a admin" do
      assert {:ok, %Admin{} = admin} = Accounts.create_admin(@valid_attrs)
      assert admin.attributes == %{}
      assert admin.email == "some email"
      assert admin.full_name == "some full_name"
      assert admin.is_active == true
      assert admin.password_hash == "some password_hash"
    end

    test "create_admin/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_admin(@invalid_attrs)
    end

    test "update_admin/2 with valid data updates the admin" do
      admin = admin_fixture()
      assert {:ok, admin} = Accounts.update_admin(admin, @update_attrs)
      assert %Admin{} = admin
      assert admin.attributes == %{}
      assert admin.email == "some updated email"
      assert admin.full_name == "some updated full_name"
      assert admin.is_active == false
      assert admin.password_hash == "some updated password_hash"
    end

    test "update_admin/2 with invalid data returns error changeset" do
      admin = admin_fixture()
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
end
