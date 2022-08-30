defmodule ExCanvas.ProjectsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ExCanvas.Projects` context.
  """

  @doc """
  Generate a canvas.
  """
  def canvas_fixture(attrs \\ %{}) do
    {:ok, canvas} =
      attrs
      |> Enum.into(%{
        height: 42,
        width: 42
      })
      |> ExCanvas.Projects.create_canvas()

    canvas
  end

  @doc """
  Generate a rectangle.
  """
  def rectangle_fixture(canvas, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        fill: "@",
        height: 8,
        outline: "|",
        width: 10,
        x: 2,
        y: 3
      })

    {:ok, rectangle} = ExCanvas.Projects.create_rectangle(canvas, attrs)

    rectangle
  end
end
