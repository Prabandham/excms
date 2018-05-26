defmodule ExCms.Sites do
  @moduledoc """
  The Sites context.
  """

  import Ecto.Query, warn: false
  alias ExCms.Repo
  alias ExCms.Sites.{Site, Page, Asset, Layout, Contact}

  # SITE RELATED FUNCTIONS

  @doc """
  Returns the list of sites.

  ## Examples

      iex> list_sites()
      [%Site{}, ...]

  """
  def list_sites do
    Site
    |> Repo.all()
    |> Repo.preload([:pages, :layouts, :assets])
  end

  @doc """
  Gets a single site.

  Raises `Ecto.NoResultsError` if the Site does not exist.

  ## Examples

      iex> get_site!(123)
      %Site{}

      iex> get_site!(456)
      ** (Ecto.NoResultsError)

  """
  def get_site!(id) do
    Site
    |> Repo.get!(id)
    |> Repo.preload([:pages, :assets, :layouts])
  end

  @doc """
    Returns the site based on the domain name
  """
  def get_site_by_domain(name) do
    Site
    |> Repo.get_by(domain_name: name)
    |> Repo.preload([:pages, :assets, :layouts])
  end

  @doc """
  Creates a site.

  ## Examples

      iex> create_site(%{field: value})
      {:ok, %Site{}}

      iex> create_site(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_site(attrs \\ %{}) do
    %Site{}
    |> Site.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a site.

  ## Examples

      iex> update_site(site, %{field: new_value})
      {:ok, %Site{}}

      iex> update_site(site, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_site(%Site{} = site, attrs) do
    site
    |> Site.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Site.

  ## Examples

      iex> delete_site(site)
      {:ok, %Site{}}

      iex> delete_site(site)
      {:error, %Ecto.Changeset{}}

  """
  def delete_site(%Site{} = site) do
    Repo.delete(site)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking site changes.

  ## Examples

      iex> change_site(site)
      %Ecto.Changeset{source: %Site{}}

  """
  def change_site(%Site{} = site) do
    Site.changeset(site, %{})
  end

  # PAGES RELATED FUNCTIONS

  @doc """
  Returns the list of pages.

  ## Examples

      iex> list_pages()
      [%Page{}, ...]

  """
  def list_pages do
    Page
    |> Repo.all()
    |> Repo.preload([:site, :layout])
  end

  def list_pages(host) do
    site = get_site_by_domain(host)

    case site do
      nil ->
        []

      _ ->
        site.pages
        |> Repo.preload([:site, :layout])
    end
  end

  @doc """
  Gets a single page.

  Raises `Ecto.NoResultsError` if the Page does not exist.

  ## Examples

      iex> get_page!(123)
      %Pages{}

      iex> get_page!(456)
      ** (Ecto.NoResultsError)

  """
  def get_page!(id), do: Page |> Repo.get!(id) |> Repo.preload([:site, :layout])

  @doc """
  Creates a page.

  ## Examples

      iex> create_page(%{field: value})
      {:ok, %Page{}}

      iex> create_page(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_page(attrs \\ %{}) do
    %Page{}
    |> Page.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a page.

  ## Examples

      iex> update_page(page, %{field: new_value})
      {:ok, %Page{}}

      iex> update_page(page, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_page(%Page{} = page, attrs) do
    page
    |> Page.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Page.

  ## Examples

      iex> delete_page(page)
      {:ok, %Page{}}

      iex> delete_page(page)
      {:error, %Ecto.Changeset{}}

  """
  def delete_page(%Page{} = page) do
    Repo.delete(page)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pages changes.

  ## Examples

      iex> change_page(page)
      %Ecto.Changeset{source: %Page{}}

  """
  def change_page(%Page{} = page) do
    Page.changeset(page, %{})
  end

  # ASSETS RELATED FUNCTIONS

  @doc """
  Returns the list of assets.

  ## Examples

      iex> list_assets()
      [%Asset{}, ...]

  """
  def list_assets do
    Asset
    |> Ecto.Query.order_by([a], desc: a.priority)
    |> Repo.all()
    |> Repo.preload(:site)
  end

  def list_assets(name) do
    site = get_site_by_domain(name)

    case site do
      nil ->
        []

      _ ->
        site.assets
        |> Repo.preload(:site)
    end
  end

  @doc """
  Gets a single asset.

  Raises `Ecto.NoResultsError` if the Asset does not exist.

  ## Examples

      iex> get_asset!(123)
      %Asset{}

      iex> get_asset!(456)
      ** (Ecto.NoResultsError)

  """
  def get_asset!(id), do: Repo.get!(Asset, id)

  @doc """
  Creates a asset.

  ## Examples

      iex> create_asset(%{field: value})
      {:ok, %Asset{}}

      iex> create_asset(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_asset(attrs \\ %{}) do
    %Asset{}
    |> Asset.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a asset.

  ## Examples

      iex> update_asset(asset, %{field: new_value})
      {:ok, %Asset{}}

      iex> update_asset(asset, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_asset(%Asset{} = asset, attrs) do
    asset
    |> Asset.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Asset.

  ## Examples

      iex> delete_asset(asset)
      {:ok, %Asset{}}

      iex> delete_asset(asset)
      {:error, %Ecto.Changeset{}}

  """
  def delete_asset(%Asset{} = asset) do
    Repo.delete(asset)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking asset changes.

  ## Examples

      iex> change_asset(asset)
      %Ecto.Changeset{source: %Asset{}}

  """
  def change_asset(%Asset{} = asset) do
    Asset.changeset(asset, %{})
  end

  # LAYOUTS RELATED FUNCTIONS

  @doc """
  Returns the list of layouts.

  ## Examples

      iex> list_layouts()
      [%Layout{}, ...]

  """
  def list_layouts do
    Repo.all(Layout)
  end

  def list_layouts(name) do
    site = get_site_by_domain(name)

    case site do
      nil ->
        []

      _ ->
        site.layouts
    end
  end

  @doc """
    Returns the list of layouts for the given site

    ## Examples

    iex> list_layouts(site.id)
    [%Layout{}, ...]
  """

  def list_layouts(site_id) do
    site = get_site!(site_id)
    site.layouts
  end

  @doc """
  Gets a single layout.

  Raises `Ecto.NoResultsError` if the Layout does not exist.

  ## Examples

      iex> get_layout!(123)
      %Layout{}

      iex> get_layout!(456)
      ** (Ecto.NoResultsError)

  """
  def get_layout!(id), do: Repo.get!(Layout, id)

  @doc """
  Creates a layout.

  ## Examples

      iex> create_layout(%{field: value})
      {:ok, %Layout{}}

      iex> create_layout(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_layout(attrs \\ %{}) do
    %Layout{}
    |> Layout.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a layout.

  ## Examples

      iex> update_layout(layout, %{field: new_value})
      {:ok, %Layout{}}

      iex> update_layout(layout, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_layout(%Layout{} = layout, attrs) do
    layout
    |> Layout.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Layout.

  ## Examples

      iex> delete_layout(layout)
      {:ok, %Layout{}}

      iex> delete_layout(layout)
      {:error, %Ecto.Changeset{}}

  """
  def delete_layout(%Layout{} = layout) do
    Repo.delete(layout)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking layout changes.

  ## Examples

      iex> change_layout(layout)
      %Ecto.Changeset{source: %Layout{}}

  """
  def change_layout(%Layout{} = layout) do
    Layout.changeset(layout, %{})
  end

  alias ExCms.Sites.Contact

  @doc """
  Returns the list of contract_messages.

  ## Examples

      iex> list_contract_messages()
      [%Contact{}, ...]

  """
  def list_contact_messages do
    Repo.all(Contact)
  end

  @doc """
  Gets a single contact.

  Raises `Ecto.NoResultsError` if the Contact does not exist.

  ## Examples

      iex> get_contact!(123)
      %Contact{}

      iex> get_contact!(456)
      ** (Ecto.NoResultsError)

  """
  def get_contact!(id), do: Repo.get!(Contact, id)

  @doc """
  Creates a contact.

  ## Examples

      iex> create_contact(%{field: value})
      {:ok, %Contact{}}

      iex> create_contact(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_contact(attrs \\ %{}) do
    %Contact{}
    |> Contact.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a contact.

  ## Examples

      iex> update_contact(contact, %{field: new_value})
      {:ok, %Contact{}}

      iex> update_contact(contact, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_contact(%Contact{} = contact, attrs) do
    contact
    |> Contact.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Contact.

  ## Examples

      iex> delete_contact(contact)
      {:ok, %Contact{}}

      iex> delete_contact(contact)
      {:error, %Ecto.Changeset{}}

  """
  def delete_contact(%Contact{} = contact) do
    Repo.delete(contact)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking contact changes.

  ## Examples

      iex> change_contact(contact)
      %Ecto.Changeset{source: %Contact{}}

  """
  def change_contact(%Contact{} = contact) do
    Contact.changeset(contact, %{})
  end
end
