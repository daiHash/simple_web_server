defmodule SimpleWebServer.SocketHandler do
  @moduledoc """
    Handle Web Sockets processes
  """
  @behaviour :cowboy_websocket

  @doc """
    Grab the path from the request and save that to the state variable that gets passed along to the websocket_init/1 function

    ## Parameters

      - request: String that represents the path of the request.

  """
  def init(request, _state) do
    state = %{registry_key: request.path}

    {:cowboy_websocket, request, state}
  end

  def websocket_init(state) do
    Registry.SimpleWebServer
    |> Registry.register(state.registry_key, {})

    {:ok, state}
  end

  @doc """
    Callback triggered when web socket is send from client.
    It would check all processes with the same PID and send back the payload to each.

    ## Parameters
      - ({:text, json}: Payload got from client
      - state: Struct with the request path data

  """
  def websocket_handle({:text, json}, state) do
    payload = Jason.decode!(json)
    message = payload["data"]["message"]

    Registry.SimpleWebServer
    |> Registry.dispatch(state.registry_key, fn(entries) ->
      for {pid, _} <- entries do
        if pid != self() do
          Process.send(pid, message, [])
        end
      end
    end)

    {:reply, {:text, message}, state}
  end

  def websocket_info(info, state) do
    {:reply, {:text, info}, state}
  end
end
