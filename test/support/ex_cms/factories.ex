defmodule ExCms.Factories do
  @moduledoc """
    This will hold a list of all factories
  """
  alias ExCms.Sites
  alias ExCms.Repo

  def valid_site_attrs(),
    do: %{
      description: "some description",
      domain_name: "some domain_name",
      google_analytics_key: "some google_analytics_key",
      is_active: true,
      meta: %{},
      name: "some name"
    }

  def update_site_attrs(),
    do: %{
      description: "some updated description",
      domain_name: "some updated domain_name",
      google_analytics_key: "some updated google_analytics_key",
      is_active: false,
      meta: %{},
      name: "some updated name"
    }

  def invalid_site_attrs(),
    do: %{
      description: nil,
      domain_name: nil,
      google_analytics_key: nil,
      is_active: nil,
      meta: nil,
      name: nil
    }

  def valid_page_attrs(),
    do: %{
      content: "some content",
      description: "some description",
      is_active: true,
      name: "some name",
      title: "some title"
    }

  def update_page_attrs(),
    do: %{
      content: "some updated content",
      description: "some updated description",
      is_active: false,
      name: "some updated name",
      title: "some updated title"
    }

  def invalid_page_attrs(),
    do: %{content: nil, description: nil, is_active: nil, name: nil, title: nil}

  def valid_layout_attrs(), do: %{content: "some content", name: "some name"}
  def update_layout_attrs(), do: %{content: "some updated content", name: "some updated name"}
  def invalid_layout_attrs(), do: %{content: nil, name: nil}

  def valid_asset_attrs(), do: %{content: "some content", name: "some name"}
  def update_asset_attrs(), do: %{content: "some updated content", name: "some updated name"}
  def invalid_asset_attrs(), do: %{content: nil, name: nil}

  def fabricate_site(attrs \\ %{}) do
    {:ok, site} =
      attrs
      |> Enum.into(valid_site_attrs())
      |> Sites.create_site()

    Sites.get_site!(site.id)
  end

  def fabricate_page(attrs \\ %{}) do
    layout = fabricate_layout()
    site = Sites.get_site!(layout.site_id)

    {:ok, pages} =
      attrs
      |> Enum.into(%{site_id: site.id, layout_id: layout.id})
      |> Enum.into(valid_page_attrs())
      |> Sites.create_page()

    pages
    |> Repo.preload([:site, :layout])
  end

  def fabricate_layout(attrs \\ %{}) do
    site = fabricate_site()

    {:ok, layout} =
      attrs
      |> Enum.into(%{site_id: site.id})
      |> Enum.into(valid_layout_attrs())
      |> Sites.create_layout()

    layout
  end

  def fabricate_asset(attrs \\ %{}) do
    site = fabricate_site()

    {:ok, asset} =
      attrs
      |> Enum.into(%{site_id: site.id})
      |> Enum.into(valid_asset_attrs())
      |> Sites.create_asset()

    asset
  end
end
