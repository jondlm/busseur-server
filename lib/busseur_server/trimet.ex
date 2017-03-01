defmodule BusseurServer.Trimet do

  defp build_url(loc_ids) do
    case System.get_env("APP_ID") do
      app_id ->
        "http://developer.trimet.org/ws/v2/arrivals?appID=#{app_id}&locIDs=#{loc_ids}"
    end
  end

  defp main_get(loc_ids) do
    case HTTPoison.get(build_url(loc_ids)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body)
      {:ok, %HTTPoison.Response{status_code: status_code, body: body}} ->
        {:error, "Trimet responded with a #{status_code}: #{body}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, "An unknown error occurred while trying to call Trimet: #{reason}"}
    end
  end

  def get_arrivals(loc_ids), do: main_get(loc_ids)
  def get_arrivals(loc_ids, route_id) do
    case main_get(loc_ids) do
      {:ok, response} ->
        %{"resultSet" => %{"arrival" => arrivals}} = response
        filtered_arrivals = Enum.filter(arrivals, fn(%{"route" => r}) ->
          r == route_id
        end)
        {:ok, put_in(response, ["resultSet", "arrival"], filtered_arrivals)}
      fail -> fail
    end
  end
end
