defmodule ExCanvasWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use ExCanvasWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{valid?: false} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ExCanvasWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
    |> halt()
  end

  def call(conn, {:error, :not_found, reason}), do: render_error(conn, :not_found, reason: reason)
  def call(conn, {:error, :not_found}), do: not_found(conn)

  def call(conn, :error), do: not_found(conn)

  def call(conn, {:error, reason}), do: render_error(conn, :bad_request, reason: reason)

  def call(conn, {:error, :input_error, reason}),
    do: render_error(conn, :bad_request, reason: reason, type: :input_error)
end
