defmodule ExCms.Utils.PageCache do
  @moduledoc """
  This will provide a caching machanism to all the sites.
"""

  @cache_table :page_cache
  import Ecto.Query

  @doc """
  Tries to get a site's map from the cache else does a db look up to see if the given domain is present

  ExCms.Utils.PageCache.get_site_from_cache(localhost)
    {:ok, %Site{domain_name: ...}}
    {:error, %{}}
"""
  def get_site_from_cache(domain_name) do
    case ConCache.get(@cache_table, domain_name) do
      nil ->
        case ExCms.Sites.get_site_by_domain(domain_name) do
          nil -> {:error, %{}}
          site -> set_site_cache(domain_name, site)
        end
      site -> {:ok, site}
    end
  end

  def set_site_cache(domain_name, site) do
    ConCache.put(@cache_table, domain_name, site)
    {:ok, ConCache.get(@cache_table, domain_name)}
  end

  @doc """
  This will handle setting of a cache for the page.

  ExCms.Utils.PageCache.set_cache(domain_name, page_name, content)
    :ok
"""
  def set_page_cache(domain_name, page_name, content) do
    key = domain_name <> "-" <> page_name
    ConCache.put(@cache_table, key, content)
  end

  @doc """
  THis will retrive the cache for a given site and page

  ExCms.Utils.PageCache.get_page_from_cache(domain_name, page_name)
    content
"""
  def get_page_from_cache(domain_name, page_name) do
    key = domain_name <> "-" <> page_name
    site = case ConCache.get(@cache_table, key) do
      site -> site
      nil -> nil
    end
    case site do
      nil ->
        {:ok, site} = get_site_from_cache(domain_name)
        [page] = ExCms.Sites.Page
          |> where(name: ^page_name, site_id: ^site.id)
          |> ExCms.Repo.all()
        content = ExCms.Utils.BuildPage.render(page.content, page.site_id, page.layout_id, page.title)
         set_page_cache(domain_name, page_name, content)
         content
      content -> content
    end
  end

  @doc """
  In case an attribute of a page has been updated like an asset / page / layout / site in itself. We will expire all
  cached items of the page.

  ExCms.Utils.PageCache.expire_cache(site)
    :ok
"""
  def expire_cache(site_id) do
    site = ExCms.Sites.get_site!(site_id)
    site.pages
    |> Enum.map(fn(page) ->
      key = site.domain_name <> "-" <> page.name
      IO.inspect("Deleting cache for - #{key}")
      ConCache.delete(@cache_table, key)
    end)
  end
end