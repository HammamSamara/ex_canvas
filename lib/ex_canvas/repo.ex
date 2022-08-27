defmodule ExCanvas.Repo do
  use Ecto.Repo,
    otp_app: :ex_canvas,
    adapter: Ecto.Adapters.Postgres

  # The `UUID` type needs to confirm to a specific standard
  # in order not to raise on failed ids.
  # Since we don't wanna rescue every where in the code, we choose
  # to override the Repo implementation which is a two liner in Elixir.
  # https://stackoverflow.com/a/53807542
  defoverridable get: 2, get: 3

  def get(query, id, opts \\ []) do
    super(query, id, opts)
  rescue
    Ecto.Query.CastError -> nil
  end

  def fetch(query, id, opts \\ []) do
    case get(query, id, opts) do
      nil -> {:error, :not_found}
      schema -> {:ok, schema}
    end
  end
end
