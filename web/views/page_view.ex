defmodule BusseurServer.PageView do
  use BusseurServer.Web, :view

  defp msec_to_date(milliseconds) do
    case milliseconds do
      s when is_number(s) ->
        {:ok, DateTime.from_unix!(div(s, 1000))}
      _ ->
        {:error, "Could not format date"}
    end
  end

  defp from_now(milliseconds) do
    case msec_to_date(milliseconds) do
      {:ok, date} ->
        case Timex.Comparable.diff(date, DateTime.utc_now(), :minutes) do
          m when div(m, 60) > 0 ->
            "#{div(m, 60)} hr #{rem(m, 60)} min"
          m ->
            "#{m} min"
        end
      _ ->
        nil
    end
  end

  def extract_location(response) do
    case response do
      %{"resultSet" => %{"location" => [location]}} ->
        "#{location["desc"]} #{location["dir"]}"
      _ ->
        "Unknown location"
    end
  end

  def extract_arrivals(response) do
    case response do
      %{"resultSet" => %{"arrival" => arrivals}} ->
        Enum.map arrivals, fn(a) ->
          a
          |> Map.put(:scheduled, from_now(a["scheduled"]))
          |> Map.put(:estimated, from_now(a["estimated"]))
        end
      _ ->
        "No arrivals found"
    end
  end
end
