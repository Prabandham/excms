defmodule ExCms.Accounts.Auth do
  @moduledoc """
  This module is responsible for authorizing an admin user into the CMS
"""

  @doc """
  Returns either true or false, incase of True it will also return the admin


  ## Examples

  iex |>
  %{:ok, admin} = ExCms.Accounts.Auth.is_valid?("valid_email", "valid_password")

  %{:error, _} = ExCms.Accounts.Auth.is_valid?("invalid_email", "invalid_password")
"""
  def is_valid?(login, password) do
    # TODO
  end
  @doc """
    Returns either true or false, incase of True it will also return the admin


    ## Examples

    iex |>
    %{:ok, admin} = ExCms.Accounts.Auth.is_valid?("Valid Token")

    %{:error, _} = ExCms.Accounts.Auth.is_valid?("Invalid Token")
  """
  def is_valid?(token) do
    # TODO
  end

  def generate_login_token(admin) do
    admin.id
  end

end
