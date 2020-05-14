defmodule ShikcheWeb.Router do
  use ShikcheWeb, :router

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

  # Other scopes may use custom stacks.
  scope "/api/v1", ShikcheWeb do
    pipe_through :api

    post "/login", LoginController, :login
    get "/languages/:name", LanguageController, :get
    # post "/translations", TranslationController, :insert
    get "/translations/:word", TranslationController, :get
    get "/*path", PageController, :not_found
  end

  scope "/", ShikcheWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/*path", PageController, :not_found
  end
end
