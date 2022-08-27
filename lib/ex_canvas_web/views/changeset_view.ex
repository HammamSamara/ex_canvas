defmodule ExCanvasWeb.ChangesetView do
  use ExCanvasWeb, :view

  def render("error.json", %{changeset: changeset}) do
    errors = translate_errors(changeset)

    %{
      errors: [
        %{
          error_code: "422",
          error: "Bad request",
          message: "Invalid request payload provided.",
          details: build_details(errors),
          changeset_details: errors
        }
      ]
    }
  end

  @doc """
  Traverses and translates changeset errors.
  See `Ecto.Changeset.traverse_errors/2` for more details.

  Usually we shouldn't use Ecto in views, and should delegate
  the functionality through the context to hide its implementation
  details.
  """
  def translate_errors(changeset),
    do: Ecto.Changeset.traverse_errors(changeset, &translate_error/1)

  defp build_details(errors) do
    errors
    |> Enum.reduce([], &reduce_message(&1, &2))
    |> Enum.join(" \n ")
  end

  defp reduce_message({key, value}, acc) when is_map(value) do
    acc ++ ["#{key}: Multiple fields have invalid values."]
  end

  defp reduce_message({key, value}, acc) do
    acc ++ ["#{key}: #{hd(value)}."]
  end
end
