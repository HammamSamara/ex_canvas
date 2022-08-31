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

  @doc """
  Generate and put rectangle into given canvas.
  """
  def canvas_24x10_fixture(attrs \\ %{}) do
    {:ok, canvas} =
      attrs
      |> Enum.into(%{
        height: 10,
        width: 24
      })
      |> ExCanvas.Projects.create_canvas()

    canvas
  end

  def rectangle_5x3_fixture(canvas, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        fill: "X",
        height: 3,
        outline: "@",
        width: 5,
        x: 3,
        y: 2
      })

    {:ok, rectangle} = ExCanvas.Projects.create_rectangle(canvas, attrs)

    rectangle
  end

  def rectangle_10x3_fixture(canvas, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        fill: "O",
        height: 6,
        outline: "X",
        width: 14,
        x: 10,
        y: 3
      })

    {:ok, rectangle} = ExCanvas.Projects.create_rectangle(canvas, attrs)

    rectangle
  end

  def canvas_24x10_fixture_2(attrs \\ %{}) do
    {:ok, canvas} =
      attrs
      |> Enum.into(%{
        height: 10,
        width: 24
      })
      |> ExCanvas.Projects.create_canvas()

    canvas
  end

  def rectangle_7x6_fixture_2(canvas, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        fill: ".",
        height: 6,
        width: 7,
        x: 14,
        y: 0
      })

    {:ok, rectangle} = ExCanvas.Projects.create_rectangle(canvas, attrs)

    rectangle
  end

  def rectangle_8x4_fixture_2(canvas, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        fill: "none",
        height: 4,
        outline: "O",
        width: 8,
        x: 0,
        y: 3
      })

    {:ok, rectangle} = ExCanvas.Projects.create_rectangle(canvas, attrs)

    rectangle
  end

  def rectangle_5x3_fixture_2(canvas, attrs \\ %{}) do
    attrs =
      Enum.into(attrs, %{
        fill: "X",
        height: 3,
        outline: "X",
        width: 5,
        x: 5,
        y: 5
      })

    {:ok, rectangle} = ExCanvas.Projects.create_rectangle(canvas, attrs)

    rectangle
  end
end
