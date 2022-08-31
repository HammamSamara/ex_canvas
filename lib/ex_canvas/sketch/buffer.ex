defmodule ExCanvas.Sketch.Buffer do
  import ExCanvas.Sketch.Render

  alias ExCanvas.Sketch.Buffer
  alias ExCanvas.Projects.{Canvas, Rectangle}

  defstruct ~w(buffer rows)a

  @moduledoc """
  Convert a Canvas and carried rectangles into a buffer (Elixir list) for display.
  """

  @spec build(Canvas.t()) :: Buffer.t()
  def build(%Canvas{rectangles: %Ecto.Association.NotLoaded{}} = canvas) do
    # Buffer shouldn't be concerned about preloading shapes or dealing with Ecto
    # if they don't present shall that makes unnecessary side effects.
    #
    # Better to raise if shapes are not an enumerable to keep the function pure.
    # Currently this head is helping keeps preload implicit if they don't present
    # which is an anti-pattern.
    canvas
    |> ExCanvas.Repo.preload(:rectangles)
    |> build()
  end

  def build(%Canvas{rectangles: rectangles} = canvas) do
    empty_slate = render(canvas)

    buffer = Enum.reduce(rectangles, empty_slate, &shape_reducer(&1, &2, canvas.width))

    %Buffer{buffer: buffer, rows: canvas.width}
  end

  defp shape_reducer(%Rectangle{} = rectangle, buffer, shift) do
    coordinates = render(rectangle)

    Enum.reduce(coordinates, buffer, fn {x, y, fill}, buffer ->
      pos = y * shift + x

      List.replace_at(buffer, pos, fill)
    end)
  end

  @type t :: %__MODULE__{buffer: List, rows: integer}
end

defimpl String.Chars, for: ExCanvas.Sketch.Buffer do
  @spec to_string(ExCanvas.Sketch.Buffer.t()) :: binary
  def to_string(%ExCanvas.Sketch.Buffer{buffer: buffer, rows: rows}) do
    buffer
    |> Stream.chunk_every(rows)
    |> Enum.join("\n")
  end
end
