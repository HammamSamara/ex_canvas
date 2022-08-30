defmodule ExCanvas.Repo.Migrations.CreateRectangles do
  use Ecto.Migration

  def change do
    create table(:rectangles, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :x, :integer
      add :y, :integer
      add :width, :integer
      add :height, :integer
      add :fill, :string
      add :outline, :string
      add :canvas_id, references(:canvases, on_delete: :delete_all, type: :binary_id)

      timestamps()
    end

    create index(:rectangles, [:canvas_id])
  end
end
