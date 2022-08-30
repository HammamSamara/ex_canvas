defmodule ExCanvasWeb.Api.RectangleController do
  use ExCanvasWeb, :controller

  alias ExCanvas.Projects

  # @spec index(Plug.Conn.t(), any) :: Plug.Conn.t()
  # def index(conn, _params) do
  #   canvases = Projects.list_canvases()

  #   render(conn, :index, canvases: canvases)
  # end

  # @spec show(Plug.Conn.t(), map) :: {:error, :not_found} | Plug.Conn.t()
  # def show(conn, %{"id" => id} = _params) do
  #   with {:ok, canvas} <- Projects.get_canvas(id) do
  #     render(conn, :show, canvas: canvas)
  #   end
  # end

  @spec create(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def create(conn, %{"canvas_id" => canvas_id} = params) do
    with {:ok, canvas} <- Projects.get_canvas(canvas_id),
         {:ok, rectangle} <- Projects.create_rectangle(canvas, params) do
      render(conn, :show, rectangle: rectangle)
    end
  end
end
