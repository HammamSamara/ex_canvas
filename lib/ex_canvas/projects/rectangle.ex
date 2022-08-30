defmodule ExCanvas.Projects.Rectangle do
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

  @doc false
  def changeset(%Canvas{} = canvas, attrs) do
    changeset =
      canvas
      |> Ecto.build_assoc(:rectangles)
      |> cast(attrs, [:x, :y, :width, :height, :fill, :outline])

    changeset
    |> validate_required([:x, :y, :width, :height])
    |> validate_required_inclusion([:fill, :outline])
    # One ascii chat at most for fill and outline
    |> validate_length(:fill, max: 1)
    |> validate_length(:outline, max: 1)
    # For a meaningful rectangle, smallest accepted dimensions is 2x2
    |> validate_number(:width, greater_than: 1, less_than: canvas.width)
    |> validate_number(:height, greater_than: 1, less_than: canvas.height)
    # Insure rectangles don't go out of parent bounds

    |> validate_inclusion(:x, 0..max_coordinate(canvas.width, get_change(changeset, :width)),
      message: "out of Canvas bound"
    )
    |> validate_inclusion(:y, 0..max_coordinate(canvas.height, get_change(changeset, :height)),
      message: "out of Canvas bound"
    )
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
end
