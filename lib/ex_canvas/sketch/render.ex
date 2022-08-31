defprotocol ExCanvas.Sketch.Render do
  @moduledoc """
  This protocol is used to generate lists (buffers) out of shapes.
  """

  @doc """
  Return one dimension list of a given shape.
  Items in the shape are the drawing bits to render.
  """
  @spec render(ExCanvas.Projects.Canvas.t() | ExCanvas.Projects.Rectangle.t()) :: [any()]
  def render(shape)
end

defimpl ExCanvas.Sketch.Render, for: ExCanvas.Projects.Canvas do
  alias ExCanvas.Projects.Canvas

  @doc """
  Generate the slate in a form of a char list to use as the drawing canvas

  Returns one dimension list filled with an initial char.
  """
  @spec render(ExCanvas.Projects.Canvas.t()) :: [any()]
  def render(%Canvas{} = canvas), do: generate_buffer(canvas)

  defp generate_buffer(%Canvas{width: w, height: h}), do: generate_buffer([], w * h, '_')
  defp generate_buffer(buffer, 0, _fill), do: buffer
  defp generate_buffer(buffer, i, fill), do: generate_buffer([fill | buffer], i - 1, fill)
end

defimpl ExCanvas.Sketch.Render, for: ExCanvas.Projects.Rectangle do
  alias ExCanvas.Projects.Rectangle

  @doc """
  Find the {x,y} coordinates with the fill ascii of a rectangle.

  Returns a three-element tuple of x and y coordinates and the fill.
  """
  @spec render(Rectangle.t()) :: [any()]
  def render(
        %Rectangle{x: x, y: y, width: width, height: height, fill: fill, outline: outline} = rect
      ) do
    coordinates =
      for xx <- x..(x + width - 1) do
        for yy <- y..(y + height - 1) do
          char = if is_outline?(xx, yy, rect), do: outline || fill, else: fill || outline

          {xx, yy, char}
        end
      end

    List.flatten(coordinates)
  end

  defp is_outline?(x, _y, rec) when x == rec.x, do: true
  defp is_outline?(_x, y, rec) when y == rec.y, do: true
  defp is_outline?(x, _y, rec) when x == rec.x + rec.width - 1, do: true
  defp is_outline?(_x, yy, rec) when yy == rec.y + rec.height - 1, do: true
  defp is_outline?(_x, _y, _rec), do: false
end
