defmodule Pushups.Router do
  use Plug.Router

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
    IO.puts "post!"
    IO.puts inspect conn.body_params, pretty: true, limit: 30000

    # resp = %{fulfillment: %{ speech: "Gregor", displayText: "Gregor", source: "agent"}}

    resp = conn.body_params
    |> Map.get("result")
    |> Map.get("fulfillment")
    |> Map.put("speech", "cool story bro!!!!!!!!")

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(resp))
  end

end
