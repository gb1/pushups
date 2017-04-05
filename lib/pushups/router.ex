defmodule Pushups.Router do
  use Plug.Router
  alias Pushups.{Routine, Reply}

  plug Plug.Parsers, parsers: [:json],
                   pass:  ["text/*"],
                   json_decoder: Poison
  plug :match
  plug :dispatch

  def start_link do
    Plug.Adapters.Cowboy.http(Pushups.Router, [])
  end

  get "/" do
    conn
    |> send_resp(200, "Plug!")
  end

  post "/boop" do
    IO.puts inspect conn.body_params, pretty: true, limit: 30000


    # IO.inspect  Poison.encode!(reply)
    case conn.body_params |> Map.get("result") |> Map.get("action") do
      "start" ->
        welcome = Routine.welcome(Routine.get_session_id(conn.body_params))
        reply = %Reply{ speech: welcome, displayText: welcome }
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Poison.encode!(reply))
      "start-yes" ->
        reply = %Reply{ speech: "ok yes", displayText: "ok" }
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Poison.encode!(reply))
      _ ->
        reply = %Reply{ speech: "???", displayText: "??" }
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, Poison.encode!(reply))
      end

  end



end
