defmodule ExCanvas.Projects.Canvas do
  @moduledoc """
  In a form of an Ecto Schema, Canvas is the basic frame to hold drawing components.

  A canvas is define by its width and height, with a minimum acceptable dimensions
  of 10x10 and a maximum of an Integer of size 4.

  Users can create as many canvases as they need, with no restrictions as limiting
  canvases per accounts is out of scope of this project.

  Destroying canvases kept an unexposed API by project scoping. Meaning that users
  are able to create, and traverse canvases, but not allow to drop them out of the system.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "canvases" do
    field :height, :integer
    field :width, :integer
    has_many :rectangles, ExCanvas.Projects.Rectangle

    timestamps()
  end

  @doc false
  def changeset(canvas, attrs) do
    canvas
    |> cast(attrs, [:width, :height])
    |> validate_required([:width, :height])
    # For a meaningful canvas, smallest accepted dimensions is 10x10
    |> validate_number(:width, greater_than_or_equal_to: 10)
    |> validate_number(:height, greater_than_or_equal_to: 10)
  end
end
