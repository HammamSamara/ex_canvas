defmodule ExCanvas.Repo do
  use Ecto.Repo,
    otp_app: :ex_canvas,
    adapter: Ecto.Adapters.Postgres
end
