defmodule Utils.BuildPage do
  @moduledoc """
  This module will take a page from the db with its sites and assets and layouts and do the neccessary parsing
  like converting the content from markdown to HTML and then render it with the proper layout.
"""
  require EEx
  def render(page) do
    layout = page.layout.content
    EEx.eval_string(layout, [title: page.title, content: page.content])
  end
end
