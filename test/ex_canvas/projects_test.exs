defmodule ExCanvas.ProjectsTest do
  use ExCanvas.DataCase

  alias ExCanvas.Projects

  describe "canvases" do
    alias ExCanvas.Projects.Canvas

    import ExCanvas.ProjectsFixtures

    @invalid_attrs %{height: nil, width: nil}

    test "list_canvases/0 returns all canvases" do
      canvas = canvas_fixture()
      assert Projects.list_canvases() == [canvas]
    end

    test "get_canvas/1 returns the canvas with given id" do
      canvas = canvas_fixture()

      assert Projects.get_canvas!(canvas.id) == canvas
    end

    test "create_canvas/1 with valid data creates a canvas" do
      valid_attrs = %{height: 42, width: 42}

      assert {:ok, %Canvas{} = canvas} = Projects.create_canvas(valid_attrs)
      assert canvas.height == 42
      assert canvas.width == 42
    end

    test "create_canvas/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Projects.create_canvas(@invalid_attrs)
    end

    test "delete_canvas/1 deletes the canvas" do
      canvas = canvas_fixture()
      assert {:ok, %Canvas{}} = Projects.delete_canvas(canvas)
      assert {:error, :not_found} = Projects.get_canvas(canvas.id)
    end
  end

  describe "rectangles" do
    import ExCanvas.ProjectsFixtures

    @invalid_attrs %{fill: nil, height: nil, outline: nil, width: nil, x: nil, y: nil}

    test "list_rectangles/0 returns all rectangles" do
      canvas = canvas_fixture()
      rectangle = rectangle_fixture(canvas)

      {:ok, canvas} = Projects.get_canvas(canvas.id)
      assert canvas.rectangles == [rectangle]

      target = canvas.rectangles |> List.first()

      assert target.fill == "@"
      assert target.height == 8
      assert target.outline == "|"
      assert target.width == 10
      assert target.x == 2
      assert target.y == 3
    end

    test "create_rectangle/1 with invalid data returns error changeset" do
      canvas = canvas_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.create_rectangle(canvas, @invalid_attrs)
    end
  end
end
