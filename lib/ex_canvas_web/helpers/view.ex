defmodule ExCanvasWeb.Helpers.View do
  def include_if_loaded(output, key, struct, view, name \\ "show.json", assigns \\ %{})

  def include_if_loaded(output, _key, %Ecto.Association.NotLoaded{}, _view, _name, _assigns),
    do: output

  def include_if_loaded(output, _key, nil, _view, _name, _assigns), do: output

  def include_if_loaded(output, key, struct, fun, _name, _assigns) when is_function(fun, 1),
    do: Map.put(output, key, fun.(struct))

  def include_if_loaded(output, key, structs, view, name, assigns) when is_list(structs),
    do: Map.put(output, key, Phoenix.View.render_many(structs, view, name, assigns))

  def include_if_loaded(output, key, struct, view, name, assigns),
    do: Map.put(output, key, Phoenix.View.render_one(struct, view, name, assigns))
end
