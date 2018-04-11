defmodule ExCms.SitesTest do
  use ExCms.DataCase

  alias ExCms.Sites

  describe "sites" do
    alias ExCms.Sites.Site

    @valid_attrs %{description: "some description", domain_name: "some domain_name", google_analytics_key: "some google_analytics_key", is_active: true, meta: %{}, name: "some name"}
    @update_attrs %{description: "some updated description", domain_name: "some updated domain_name", google_analytics_key: "some updated google_analytics_key", is_active: false, meta: %{}, name: "some updated name"}
    @invalid_attrs %{description: nil, domain_name: nil, google_analytics_key: nil, is_active: nil, meta: nil, name: nil}

    def site_fixture(attrs \\ %{}) do
      {:ok, site} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sites.create_site()

      site
    end

    test "list_sites/0 returns all sites" do
      site = site_fixture()
      assert Sites.list_sites() == [site]
    end

    test "get_site!/1 returns the site with given id" do
      site = site_fixture()
      assert Sites.get_site!(site.id) == site
    end

    test "create_site/1 with valid data creates a site" do
      assert {:ok, %Site{} = site} = Sites.create_site(@valid_attrs)
      assert site.description == "some description"
      assert site.domain_name == "some domain_name"
      assert site.google_analytics_key == "some google_analytics_key"
      assert site.is_active == true
      assert site.meta == %{}
      assert site.name == "some name"
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_site(@invalid_attrs)
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()
      assert {:ok, site} = Sites.update_site(site, @update_attrs)
      assert %Site{} = site
      assert site.description == "some updated description"
      assert site.domain_name == "some updated domain_name"
      assert site.google_analytics_key == "some updated google_analytics_key"
      assert site.is_active == false
      assert site.meta == %{}
      assert site.name == "some updated name"
    end

    test "update_site/2 with invalid data returns error changeset" do
      site = site_fixture()
      assert {:error, %Ecto.Changeset{}} = Sites.update_site(site, @invalid_attrs)
      assert site == Sites.get_site!(site.id)
    end

    test "delete_site/1 deletes the site" do
      site = site_fixture()
      assert {:ok, %Site{}} = Sites.delete_site(site)
      assert_raise Ecto.NoResultsError, fn -> Sites.get_site!(site.id) end
    end

    test "change_site/1 returns a site changeset" do
      site = site_fixture()
      assert %Ecto.Changeset{} = Sites.change_site(site)
    end
  end

  describe "pages" do
    alias ExCms.Sites.Pages

    @valid_attrs %{content: "some content", description: "some description", is_active: true, name: "some name", title: "some title"}
    @update_attrs %{content: "some updated content", description: "some updated description", is_active: false, name: "some updated name", title: "some updated title"}
    @invalid_attrs %{content: nil, description: nil, is_active: nil, name: nil, title: nil}

    def pages_fixture(attrs \\ %{}) do
      {:ok, pages} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sites.create_pages()

      pages
    end

    test "list_pages/0 returns all pages" do
      pages = pages_fixture()
      assert Sites.list_pages() == [pages]
    end

    test "get_pages!/1 returns the pages with given id" do
      pages = pages_fixture()
      assert Sites.get_pages!(pages.id) == pages
    end

    test "create_pages/1 with valid data creates a pages" do
      assert {:ok, %Pages{} = pages} = Sites.create_pages(@valid_attrs)
      assert pages.content == "some content"
      assert pages.description == "some description"
      assert pages.is_active == true
      assert pages.name == "some name"
      assert pages.title == "some title"
    end

    test "create_pages/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_pages(@invalid_attrs)
    end

    test "update_pages/2 with valid data updates the pages" do
      pages = pages_fixture()
      assert {:ok, pages} = Sites.update_pages(pages, @update_attrs)
      assert %Pages{} = pages
      assert pages.content == "some updated content"
      assert pages.description == "some updated description"
      assert pages.is_active == false
      assert pages.name == "some updated name"
      assert pages.title == "some updated title"
    end

    test "update_pages/2 with invalid data returns error changeset" do
      pages = pages_fixture()
      assert {:error, %Ecto.Changeset{}} = Sites.update_pages(pages, @invalid_attrs)
      assert pages == Sites.get_pages!(pages.id)
    end

    test "delete_pages/1 deletes the pages" do
      pages = pages_fixture()
      assert {:ok, %Pages{}} = Sites.delete_pages(pages)
      assert_raise Ecto.NoResultsError, fn -> Sites.get_pages!(pages.id) end
    end

    test "change_pages/1 returns a pages changeset" do
      pages = pages_fixture()
      assert %Ecto.Changeset{} = Sites.change_pages(pages)
    end
  end

  describe "assets" do
    alias ExCms.Sites.Asset

    @valid_attrs %{content: "some content", name: "some name"}
    @update_attrs %{content: "some updated content", name: "some updated name"}
    @invalid_attrs %{content: nil, name: nil}

    def asset_fixture(attrs \\ %{}) do
      {:ok, asset} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sites.create_asset()

      asset
    end

    test "list_assets/0 returns all assets" do
      asset = asset_fixture()
      assert Sites.list_assets() == [asset]
    end

    test "get_asset!/1 returns the asset with given id" do
      asset = asset_fixture()
      assert Sites.get_asset!(asset.id) == asset
    end

    test "create_asset/1 with valid data creates a asset" do
      assert {:ok, %Asset{} = asset} = Sites.create_asset(@valid_attrs)
      assert asset.content == "some content"
      assert asset.name == "some name"
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_asset(@invalid_attrs)
    end

    test "update_asset/2 with valid data updates the asset" do
      asset = asset_fixture()
      assert {:ok, asset} = Sites.update_asset(asset, @update_attrs)
      assert %Asset{} = asset
      assert asset.content == "some updated content"
      assert asset.name == "some updated name"
    end

    test "update_asset/2 with invalid data returns error changeset" do
      asset = asset_fixture()
      assert {:error, %Ecto.Changeset{}} = Sites.update_asset(asset, @invalid_attrs)
      assert asset == Sites.get_asset!(asset.id)
    end

    test "delete_asset/1 deletes the asset" do
      asset = asset_fixture()
      assert {:ok, %Asset{}} = Sites.delete_asset(asset)
      assert_raise Ecto.NoResultsError, fn -> Sites.get_asset!(asset.id) end
    end

    test "change_asset/1 returns a asset changeset" do
      asset = asset_fixture()
      assert %Ecto.Changeset{} = Sites.change_asset(asset)
    end
  end

  describe "layouts" do
    alias ExCms.Sites.Layout

    @valid_attrs %{content: "some content", name: "some name"}
    @update_attrs %{content: "some updated content", name: "some updated name"}
    @invalid_attrs %{content: nil, name: nil}

    def layout_fixture(attrs \\ %{}) do
      {:ok, layout} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sites.create_layout()

      layout
    end

    test "list_layouts/0 returns all layouts" do
      layout = layout_fixture()
      assert Sites.list_layouts() == [layout]
    end

    test "get_layout!/1 returns the layout with given id" do
      layout = layout_fixture()
      assert Sites.get_layout!(layout.id) == layout
    end

    test "create_layout/1 with valid data creates a layout" do
      assert {:ok, %Layout{} = layout} = Sites.create_layout(@valid_attrs)
      assert layout.content == "some content"
      assert layout.name == "some name"
    end

    test "create_layout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_layout(@invalid_attrs)
    end

    test "update_layout/2 with valid data updates the layout" do
      layout = layout_fixture()
      assert {:ok, layout} = Sites.update_layout(layout, @update_attrs)
      assert %Layout{} = layout
      assert layout.content == "some updated content"
      assert layout.name == "some updated name"
    end

    test "update_layout/2 with invalid data returns error changeset" do
      layout = layout_fixture()
      assert {:error, %Ecto.Changeset{}} = Sites.update_layout(layout, @invalid_attrs)
      assert layout == Sites.get_layout!(layout.id)
    end

    test "delete_layout/1 deletes the layout" do
      layout = layout_fixture()
      assert {:ok, %Layout{}} = Sites.delete_layout(layout)
      assert_raise Ecto.NoResultsError, fn -> Sites.get_layout!(layout.id) end
    end

    test "change_layout/1 returns a layout changeset" do
      layout = layout_fixture()
      assert %Ecto.Changeset{} = Sites.change_layout(layout)
    end
  end
end
