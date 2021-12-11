defmodule GuiChallengeWeb.ConverterLive.Index do
  use GuiChallengeWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket
          |> assign(:celsius, 0)
          |> assign(:fahrenheit, 0)
    }
  end

  def handle_event("set_celsius", %{"celsius" => celsius}, socket) do
    case Integer.parse(celsius) do
      {celsius, ""} ->
        socket
        |> assign(:celsius, celsius)
        |> assign(:fahrenheit, to_fahrenheit(celsius))
        |> put_flash(:error, nil)
        |> no_reply()

      :error ->
        error_reply(socket)
    end
  end

  def handle_event("set_fahrenheit", %{"fahrenheit" => fahrenheit}, socket) do
    case Integer.parse(fahrenheit) do
      {fahrenheit, ""} ->
        celsius = to_celsius(fahrenheit)
        socket
        |> assign(:celsius, celsius)
        |> assign(:fahrenheit, fahrenheit)
        |> put_flash(:error, nil)
        |> no_reply()

      :error ->
        error_reply(socket)
    end
  end

  defp to_celsius(fahrenheit), do: (fahrenheit - 32) * 5 / 9

  defp to_fahrenheit(celsius), do: (celsius) * 9 / 5 + 32

  defp no_reply(socket), do: {:noreply, socket}

  defp error_reply(socket) do
    socket
    |> put_flash(:error, "Temperature must be a number")
    |> no_reply()
  end

end
