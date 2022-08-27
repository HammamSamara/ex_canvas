defmodule ExCanvasWeb.Helpers.Rendering do
  @moduledoc """
  Handy functions for rendering common input errors
  by users.

  Usually utilized in the fallback controller, and can be used as well
  in controllers directly as the module is injected in the ExCanvasWeb.controller/0
  for convenience.
  """
  import Plug.Conn
  import Phoenix.Controller

  def render_error(conn, status, assigns \\ [])

  def render_error(conn, status, assigns) do
    conn
    |> put_status(status)
    |> put_layout(false)
    |> put_view(ExCanvasWeb.ErrorView)
    |> render(:"#{status}", assigns)
    |> halt()
  end

  def not_found(conn, assigns \\ []) do
    render_error(conn, 404, assigns)
  end

  def unprocessable_entity(conn, assigns \\ []) do
    render_error(conn, :unprocessable_entity, assigns)
  end
end
