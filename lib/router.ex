defmodule SimpleWebServer.Router do
  use Plug.Router
  require EEx

  plug(Plug.Static,
    at: "/",
    from: :simple_web_server,
    only: ~w(css images js)
  )

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  EEx.function_from_file(:defp, :application_html, "lib/application.html.eex", [])
  EEx.function_from_file(:defp, :not_found_html, "lib/not_found.html.eex", [])

  get "/" do
    send_resp(conn, 200, application_html())
  end

  match _ do
    send_resp(conn, 404, not_found_html())
  end
end
