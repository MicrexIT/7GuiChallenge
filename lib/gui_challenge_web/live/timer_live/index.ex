defmodule GuiChallengeWeb.TimerLive.Index do
  use GuiChallengeWeb, :live_view
  @min 0

  def mount(_params, _session, socket) do
    socket = socket
             |> assign(:duration, 0)
             |> assign(:elapsed, 0)

    if connected?(socket), do: schedule_timer()

    {:ok, socket}
  end

  def schedule_timer() do
    IO.inspect("scheduling timer")
    :timer.send_interval(1_000, :tick)
  end

  def handle_info(:tick, socket) do
    IO.inspect("called handle info")
    elapsed = socket.assigns.elapsed
    duration = socket.assigns.duration

    if elapsed < duration do
      socket
      |> update(:elapsed, fn time -> time + 1 end)
      |> noreply()
    else
      noreply(socket)
    end
  end

  def handle_event("update-duration", %{"value" => value}, socket) do
    IO.inspect("update duration")
    socket
    |> assign(:duration, String.to_integer(value))
    |> noreply()
  end

  def handle_event("reset", _, socket) do
    socket
    |> assign(:elapsed, 0)
    |> noreply()
  end

  defp noreply(socket), do: {:noreply, socket}

  defp min(), do: @min

  defp low(max) do
    if max == @min do
      @min
    end

    33 * (max - @min) / 100

  end

  defp high(max) do
    2 * low(max)
  end

  defp optimum(max) do
    2.5 * low(max)
  end

end