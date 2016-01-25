defmodule BusseurServer.PageController do
  use BusseurServer.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def show(conn, %{"stop" => stop, "route" => route}) when stop !== "" and route !== "" do
    case Integer.parse(route) do
      {parsed_route, _} ->
        {:ok, response} = BusseurServer.Trimet.get_arrivals(stop, parsed_route)
        render conn, "show.html", %{response: response}
      _ ->
        conn
        |> put_flash(:error, "Please enter a number for the route")
        |> redirect(to: "/")
    end
  end
  def show(conn, %{"stop" => stop}) when stop !== "" do
    {:ok, response} = BusseurServer.Trimet.get_arrivals(stop)
    render(conn, "show.html", %{response: response})
  end
  def show(conn, _params) do
    conn
    |> put_flash(:info, "Please enter a Stop ID")
    |> redirect(to: "/")
  end
end
