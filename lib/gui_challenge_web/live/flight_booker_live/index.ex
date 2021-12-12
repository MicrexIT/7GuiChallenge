defmodule GuiChallengeWeb.FlightBookerLive.Index do
  use GuiChallengeWeb, :live_view
  alias GuiChallenge.FlightBookers

  def mount(_params, _session, socket) do
    changeset = FlightBookers.new_booking_changes()
    flight_types = FlightBookers.flight_types()

    {:ok, assign(socket, changeset: changeset, flight_types: flight_types)}
  end

#  def handle_event("validate", %{"booking" => params}, socket) do
  def handle_event("validate", all_params, socket) do
    IO.inspect("validate handle event")
    IO.inspect(all_params, label: "all_params")
    IO.inspect(socket, label: "socket")
    %{"booking" => params} = all_params
    changeset = FlightBookers.change_booking(socket.assigns.changeset, params)

    socket
    |> assign(:changeset, changeset)
    |> noreply()
  end

  def handle_event("book", %{"booking" => params}, socket) do
    {:ok, message} =
      socket.assigns.changeset
      |> FlightBookers.change_booking(params)
      |> FlightBookers.book_trip()

    socket
    |> put_flash(:info, message)
    |> noreply()
  end

  defp date_class(changeset, field) do
    if changeset.errors[field] do
      "invalid"
    end
  end

  defp one_way_flight?(changeset) do
    FlightBookers.one_way?(changeset.changes)
  end

  defp noreply(socket), do: {:noreply, socket}

end
