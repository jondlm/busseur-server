defmodule BusseurServer.ArrivalController do
  use BusseurServer.Web, :controller

  def index(conn, %{"locIDs" => loc_ids}) when loc_ids !== "" do
    case BusseurServer.Trimet.get_arrivals(loc_ids) do
      {:ok, arrivals} -> json conn, arrivals
      {:error, error} -> json conn, %{error: error}
    end
  end
  def index(conn, _params) do
    json conn, %{error: "Missing the `locIDs` query string parameter"}
  end
end
