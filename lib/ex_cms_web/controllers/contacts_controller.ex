defmodule ExCmsWeb.ContactsController do
  @moduledoc false
  use ExCmsWeb, :controller


  def index(conn, params) do
    host = conn.host
    contacts = ExCms.Sites.list_contact_messages(host)
    |> ExCms.Repo.paginate(params)

    render conn, :index, contacts: contacts
  end

  def create(conn, %{ "contacts" => contacts_params }) do
    case ExCms.Sites.create_contact(contacts_params) do
      {:ok, contact} -> render(conn, "create.json", message: "Thank you, for reaching out to us. We will get back to you as soon as possible.")
      {:error, contact} -> render(conn, "create.json", message: "Something went wrong in saving you message. Please try again !")
    end
  end
end