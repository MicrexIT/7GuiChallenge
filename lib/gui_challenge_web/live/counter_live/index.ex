defmodule GuiChallengeWeb.CounterLive.Index do
  use GuiChallengeWeb, :live_view

  def mount(_params, _session, socket) do
    IO.inspect(socket, label: "mount")
    {:ok, assign(socket, :count, 0)}
  end

  def handle_event("count", _params, socket) do
    IO.inspect(socket, label: "here")
    socket
    |> update(:count, &(&1+1))
    |> no_reply()
  end

  defp no_reply(socket), do: {:noreply, socket}
end
