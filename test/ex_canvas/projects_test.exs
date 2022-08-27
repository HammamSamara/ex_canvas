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

    test "get_canvas!/1 returns the canvas with given id" do
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

    test "update_canvas/2 with valid data updates the canvas" do
      canvas = canvas_fixture()
      update_attrs = %{height: 43, width: 43}

      assert {:ok, %Canvas{} = canvas} = Projects.update_canvas(canvas, update_attrs)
      assert canvas.height == 43
      assert canvas.width == 43
    end

    test "update_canvas/2 with invalid data returns error changeset" do
      canvas = canvas_fixture()
      assert {:error, %Ecto.Changeset{}} = Projects.update_canvas(canvas, @invalid_attrs)
      assert canvas == Projects.get_canvas!(canvas.id)
    end

    test "delete_canvas/1 deletes the canvas" do
      canvas = canvas_fixture()
      assert {:ok, %Canvas{}} = Projects.delete_canvas(canvas)
      assert_raise Ecto.NoResultsError, fn -> Projects.get_canvas!(canvas.id) end
    end

    test "change_canvas/1 returns a canvas changeset" do
      canvas = canvas_fixture()
      assert %Ecto.Changeset{} = Projects.change_canvas(canvas)
    end
  end
end
