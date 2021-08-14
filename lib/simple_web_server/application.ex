defmodule SimpleWebServer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy,
        scheme: :http, plug: SimpleWebServer.Router, options: [dispatch: dispatch(), port: 8080]},
      {Registry, keys: :duplicate, name: Registry.SimpleWebServer}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimpleWebServer.Supervisor]
    Logger.info("Starting application in http://localhost:8080")
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    [
      {:_,
        [
          {"/ws/[...]", SimpleWebServer.SocketHandler, []},
          {:_, Plug.Cowboy.Handler, {SimpleWebServer.Router, []}}
        ]}
    ]
  end
end
