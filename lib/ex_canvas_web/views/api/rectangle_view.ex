defmodule ExCanvasWeb.Api.RectangleView do
  use ExCanvasWeb, :view

  def render("index" <> _, %{rectangles: rectangles}) do
    render_many(rectangles, __MODULE__, "show")
  end

  def render("show" <> _, %{rectangle: rectangle}) do
    %{
      id: rectangle.id,
      x: rectangle.x,
      y: rectangle.y,
      width: rectangle.width,
      height: rectangle.height,
      outline: rectangle.outline,
      fill: rectangle.fill,
      inserted_at: rectangle.inserted_at,
      updated_at: rectangle.updated_at
    }
  end
end
