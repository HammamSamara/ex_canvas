defmodule ExCanvas.Sketch.Buffer do
  import ExCanvas.Sketch.Render

  alias ExCanvas.Projects.{Canvas, Rectangle}

  defstruct ~w(buffer rows)a

  @moduledoc """
  Convert a Canvas and carried rectangles into a buffer (Elixir list) for display.
  """

  @spec init(Canvas.t()) :: %__MODULE__{}
  def init(%Canvas{rectangles: rectangles} = canvas) do
    empty_slate = render(canvas)

    buffer = Enum.reduce(rectangles, empty_slate, &shape_reducer(&1, &2, canvas.width))

    %__MODULE__{buffer: buffer, rows: canvas.width}
  end

  @spec to_string(%__MODULE__{}) :: String.t()
  def to_string(%__MODULE__{buffer: buffer, rows: rows}) do
    buffer
    |> Stream.chunk_every(rows)
    |> Enum.join("\n")

    # |> IO.puts()
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
