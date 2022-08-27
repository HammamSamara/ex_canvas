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
end
