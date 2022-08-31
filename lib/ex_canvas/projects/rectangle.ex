defmodule ExCanvas.Projects.Rectangle do
  @moduledoc """
  In a form of an Ecto Schema, Rectangle is the basic shape to mark drawing components.

  A rectangle is define by its width and height, starting coordinates, a fill or outline or both,
  with a minimum acceptable dimensions of 2x2 and a maximum of an Integer of size 4.

  Users can create as many rectangles as they need, with no restrictions as limiting
  shapes per accounts is out of scope of this project.
  """
  use Ecto.Schema

  import Ecto.Changeset

  alias ExCanvas.Projects.Canvas

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "rectangles" do
    field :fill, :string
    field :height, :integer
    field :outline, :string
    field :width, :integer
    field :x, :integer
    field :y, :integer
    belongs_to :canvas, Canvas

    timestamps()
  end

  @required ~w(x y width height)a

  @doc false
  def changeset(%Canvas{} = canvas, attrs) do
    changeset =
      canvas
      |> Ecto.build_assoc(:rectangles)
      |> cast(attrs, @required ++ [:fill, :outline])

    changeset
    |> validate_required(@required)
    |> validate_required_inclusion([:fill, :outline])
    # One ascii char at most for fill and outline
    |> set_fill_if_none()
    |> validate_length(:fill, max: 1)
    |> validate_length(:outline, max: 1)
    # For a meaningful rectangle, smallest accepted dimensions is 2x2
    |> validate_number(:width, greater_than: 1, less_than: canvas.width)
    |> validate_number(:height, greater_than: 1, less_than: canvas.height)
    # Insure rectangles don't go out of parent boundaries
    |> validate_inclusion(:x, 0..max_coordinate(canvas.width, get_change(changeset, :width)),
      message: "out of Canvas boundary"
    )
    |> validate_inclusion(:y, 0..max_coordinate(canvas.height, get_change(changeset, :height)),
      message: "out of Canvas boundary"
    )
  end

  defp set_fill_if_none(changeset) do
    # Handy way of accepting "none" as a no fill option
    # Otherwise, let the validation flow continue
    case get_change(changeset, :fill) do
      "none" -> put_change(changeset, :fill, " ")
      _ -> changeset
    end
  end

  defp validate_required_inclusion(changeset, fields) do
    if Enum.any?(fields, &get_field(changeset, &1)) do
      changeset
    else
      add_error(changeset, hd(fields), "One of these fields must be present: #{inspect(fields)}")
    end
  end

  defp max_coordinate(_d, nil), do: 0
  defp max_coordinate(d, l) when is_number(l), do: d - l

  defp max_coordinate(d, l) do
    case Integer.parse(l) do
      {int, ""} -> max_coordinate(d, int)
      _ -> 0
    end
  end

  @type t :: %__MODULE__{
          id: binary(),
          height: integer(),
          width: integer(),
          x: integer(),
          y: integer(),
          fill: String.t(),
          outline: String.t(),
          canvas: Canvas.t(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }
end
