defmodule GuiChallenge.Repo do
  use Ecto.Repo,
    otp_app: :gui_challenge,
    adapter: Ecto.Adapters.Postgres
end
