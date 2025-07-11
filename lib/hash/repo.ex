defmodule Hash.Repo do
  use Ecto.Repo,
    otp_app: :hash,
    adapter: Ecto.Adapters.Postgres
end
