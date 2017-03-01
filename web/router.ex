defmodule BusseurServer.Router do
  use BusseurServer.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BusseurServer do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/arrivals", PageController, :show
  end

  scope "/api", BusseurServer do
    pipe_through :api

    get "/arrivals", ArrivalController, :index
  end
end
