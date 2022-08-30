defmodule ExCanvas.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias ExCanvas.Repo

  alias ExCanvas.Projects.Canvas

  @doc """
  Returns the list of canvases.

  ## Examples

      iex> list_canvases()
      [%Canvas{}, ...]

  """
  def list_canvases do
    Repo.all(Canvas)
  end

  @doc """
  Gets a single canvas.

  ## Examples

      iex> get_canvas(123)
      {:ok, %Canvas{}}

      iex> get_canvas(456)
      {:error, :not_found}

  """
  def get_canvas(id), do: Canvas |> Ecto.Query.preload(:rectangles) |> Repo.fetch(id)

  @doc """
  Gets a single canvas.

  Raises `Ecto.NoResultsError` if the Canvas does not exist.

  ## Examples

      iex> get_canvas!(123)
      %Canvas{}

      iex> get_canvas!(456)
      ** (Ecto.NoResultsError)

  """
  def get_canvas!(id), do: Repo.get!(Canvas, id)

  @doc """
  Creates a canvas.

  ## Examples

      iex> create_canvas(%{field: value})
      {:ok, %Canvas{}}

      iex> create_canvas(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_canvas(attrs \\ %{}) do
    %Canvas{}
    |> Canvas.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a canvas.

  ## Examples

      iex> delete_canvas(canvas)
      {:ok, %Canvas{}}

      iex> delete_canvas(canvas)
      {:error, %Ecto.Changeset{}}

  """
  def delete_canvas(%Canvas{} = canvas) do
    Repo.delete(canvas)
  end

  alias ExCanvas.Projects.Rectangle

  @doc """
  Creates a rectangle.

  ## Examples

      iex> create_rectangle(canvas, %{field: value})
      {:ok, %Rectangle{}}

      iex> create_rectangle(canvas, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rectangle(%Canvas{} = canvas, attrs \\ %{}) do
    canvas
    |> Rectangle.changeset(attrs)
    |> Repo.insert()
  end
end
