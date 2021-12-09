defmodule GuiChallengeWeb.PageController do
  use GuiChallengeWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
