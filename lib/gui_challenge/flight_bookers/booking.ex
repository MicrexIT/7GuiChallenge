defmodule GuiChallenge.FlightBookers.Booking do
  use Ecto.Schema

  import Ecto.Changeset

  @flight_types [:one_way, :two_way]

  embedded_schema do
    field :flight_type, Ecto.Enum, values: @flight_types
    field :departure, :date
    field :return, :date
  end

  def flight_types(), do: @flight_types

  def changeset(booking, changes) do
    case changes["flight_type"] do
      "one_way" -> one_way_changeset(booking, changes)
      "two_way" -> two_way_changeset(booking, changes)
    end
  end

  def one_way_changeset(booking, changes \\ %{}) do
    booking
    |> cast(changes, [:flight_type, :departure])
    |> validate_required([:flight_type, :departure])
    |> validate_inclusion(:flight_type, [:one_way])
  end

  def two_way_changeset(booking, changes \\ %{}) do
    booking
    |> cast(changes, [:flight_type, :departure, :return])
    |> validate_required([:flight_type, :departure, :return])
    |> validate_inclusion(:flight_type, [:two_way])
    |> validate_return_and_departure()
  end

  defp validate_return_and_departure(changeset) do
    departure = get_field(changeset, :departure)
    return = get_field(changeset, :return)

    if departure && return && Date.compare(departure, return) != :lt do
      add_date_mismatch_error(changeset)
    else
      changeset
    end
  end

  defp add_date_mismatch_error(changeset) do
    if Enum.empty?(changeset.errors) do
      add_error(changeset, :date_mismatch, "must be after departure date")
    else
      changeset
    end
  end



end
