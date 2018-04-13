defmodule ExCms.SitesTest do
  use ExCms.DataCase
  alias ExCms.Factories
  alias ExCms.Sites

  describe "sites" do
    alias ExCms.Sites.Site

    def site_fixture() do
      Factories.fabricate_site()
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
      assert {:ok, %Site{} = site} = Sites.create_site(Factories.valid_site_attrs())
      assert site.description == "some description"
      assert site.domain_name == "some domain_name"
      assert site.google_analytics_key == "some google_analytics_key"
      assert site.is_active == true
      assert site.meta == %{}
      assert site.name == "some name"
    end

    test "create_site/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_site(Factories.invalid_site_attrs())
    end

    test "update_site/2 with valid data updates the site" do
      site = site_fixture()
      assert {:ok, site} = Sites.update_site(site, Factories.update_site_attrs())
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
      assert {:error, %Ecto.Changeset{}} = Sites.update_site(site, Factories.invalid_site_attrs())
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
    alias ExCms.Sites.Page

    def pages_fixture() do
      Factories.fabricate_page()
    end

    test "list_pages/0 returns all pages" do
      pages = pages_fixture()
      assert Sites.list_pages() == [pages]
    end

    test "get_pages!/1 returns the pages with given id" do
      pages = pages_fixture()
      assert Sites.get_page!(pages.id) == pages
    end

    test "create_pages/1 with valid data creates a pages" do
      layout = Factories.fabricate_layout()
      site = Sites.get_site!(layout.site_id)

      valid_page_attrs =
        Enum.into(Factories.valid_page_attrs(), %{site_id: site.id, layout_id: layout.id})

      assert {:ok, %Page{} = pages} = Sites.create_page(valid_page_attrs)
      assert pages.content == "some content"
      assert pages.description == "some description"
      assert pages.is_active == true
      assert pages.name == "some name"
      assert pages.title == "some title"
    end

    test "create_pages/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_page(Factories.invalid_page_attrs())
    end

    test "update_pages/2 with valid data updates the pages" do
      pages = pages_fixture()
      assert {:ok, pages} = Sites.update_page(pages, Factories.update_page_attrs())
      assert %Page{} = pages
      assert pages.content == "some updated content"
      assert pages.description == "some updated description"
      assert pages.is_active == false
      assert pages.name == "some updated name"
      assert pages.title == "some updated title"
    end

    test "update_pages/2 with invalid data returns error changeset" do
      pages = pages_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sites.update_page(pages, Factories.invalid_page_attrs())

      assert pages == Sites.get_page!(pages.id)
    end

    test "delete_pages/1 deletes the pages" do
      pages = pages_fixture()
      assert {:ok, %Page{}} = Sites.delete_page(pages)
      assert_raise Ecto.NoResultsError, fn -> Sites.get_page!(pages.id) end
    end

    test "change_pages/1 returns a pages changeset" do
      pages = pages_fixture()
      assert %Ecto.Changeset{} = Sites.change_page(pages)
    end
  end

  describe "assets" do
    alias ExCms.Sites.Asset

    def asset_fixture() do
      Factories.fabricate_asset()
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
      site = Factories.fabricate_site()
      valid_asset_attrs = Enum.into(Factories.valid_asset_attrs(), %{site_id: site.id})
      assert {:ok, %Asset{} = asset} = Sites.create_asset(valid_asset_attrs)
      assert asset.content == "some content"
      assert asset.name == "some name"
    end

    test "create_asset/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_asset(Factories.invalid_asset_attrs())
    end

    test "update_asset/2 with valid data updates the asset" do
      asset = asset_fixture()
      assert {:ok, asset} = Sites.update_asset(asset, Factories.update_asset_attrs())
      assert %Asset{} = asset
      assert asset.content == "some updated content"
      assert asset.name == "some updated name"
    end

    test "update_asset/2 with invalid data returns error changeset" do
      asset = asset_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sites.update_asset(asset, Factories.invalid_asset_attrs())

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

    def layout_fixture() do
      Factories.fabricate_layout()
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
      site = Factories.fabricate_site()
      valid_layout_attrs = Enum.into(Factories.valid_layout_attrs(), %{site_id: site.id})
      assert {:ok, %Layout{} = layout} = Sites.create_layout(valid_layout_attrs)
      assert layout.content == "some content"
      assert layout.name == "some name"
    end

    test "create_layout/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_layout(Factories.invalid_layout_attrs())
    end

    test "update_layout/2 with valid data updates the layout" do
      layout = layout_fixture()
      assert {:ok, layout} = Sites.update_layout(layout, Factories.update_layout_attrs())
      assert %Layout{} = layout
      assert layout.content == "some updated content"
      assert layout.name == "some updated name"
    end

    test "update_layout/2 with invalid data returns error changeset" do
      layout = layout_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Sites.update_layout(layout, Factories.invalid_layout_attrs())

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
