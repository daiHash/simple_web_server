# SimpleWebServer
Simple Chat Server(Web Sockets) in Elixir using Cowboy and Plug

## Get Started

To run server locally.
- After cloning this repo, run in the root `mix deps.get` to install all dependency packages
```bash
mix deps.get
```

- After all packages are installed, run `mix run --no-halt` to start the server:
```bash
mix run --no-halt
```

- When server is up and running, open localhost:8080 to see a simple chat interface 

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `simple_web_server` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:simple_web_server, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/simple_web_server](https://hexdocs.pm/simple_web_server).

