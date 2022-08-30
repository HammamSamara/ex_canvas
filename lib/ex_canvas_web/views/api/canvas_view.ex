defmodule ExCanvasWeb.Api.CanvasView do
  use ExCanvasWeb, :view

  alias ExCanvasWeb.Api.RectangleView

  def render("index" <> _, %{canvases: canvases}) do
    render_many(canvases, __MODULE__, "show")
  end

  def render("show" <> _, %{canvas: canvas}) do
    %{
      id: canvas.id,
      width: canvas.width,
      height: canvas.height,
      inserted_at: canvas.inserted_at,
      updated_at: canvas.updated_at
    }
    |> include_if_loaded(:rectangles, canvas.rectangles, RectangleView, "show")
  end
end
